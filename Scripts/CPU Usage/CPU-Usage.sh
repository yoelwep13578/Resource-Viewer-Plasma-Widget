#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                   # [1] Icon Mode
                           # [2] Inline Text Mode
                           # [3] Breakline Text Mode

show_as="1"                # [1] Percent
                           # [2] Percent + Current Speed
                           # [3] Current Speed

separator=" | "            # Fill in with the separator of your choice

textmode_title="CPU:"      # Title in Text Mode
icon="\uf4bc"              # Icon in Icon Mode (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)

spacing="1"                # Spacing between Icon/Title and Output

target="overall"           # "overall" for all cores, or specific core (e.g. "1" for core 1)



#====================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#====================================

# Function to get/create spacing
get_spacing() {
  # Check if spacing value is positive
  if [[ "$spacing" =~ ^[0-9]+$ ]]; then
    printf "%${spacing}s" ""
  else
    printf "" # Fallback to 0 if invalid/minus
  fi
}

# Function to get CPU usage
get_cpu_usage() {
  if [[ $target == "overall" ]]; then
    top -bn1 | grep "Cpu(s)" | awk '{usage=100-$8} END {print usage}'
  else
    mpstat -P "$target" 1 1 | awk -v core="$target" '
    BEGIN {idle_col=13}
    $3 == core {idle=$idle_col}
    END {print 100-idle}
    '
  fi
}

# Function to get current CPU speed
get_cpu_speed() {
  if [[ $target == "overall" ]]; then
    cat /proc/cpuinfo | grep "MHz" | awk 'NR==1 {printf "%.1fGHz", $4/1000}'
  else
    freq_path="/sys/devices/system/cpu/cpu$target/cpufreq/scaling_cur_freq"
    if [[ -f "$freq_path" ]]; then
      freq=$(cat "$freq_path")
      echo "$(awk "BEGIN {printf \"%.1fGHz\", $freq/1000000}")"
    else
      echo "N/A"
    fi
  fi
}

# Get valur string according show_as
get_value_string() {
  usage=$(get_cpu_usage)
  speed=$(get_cpu_speed)
  case $show_as in
    1) echo "$(printf "%.0f" "$usage")%" ;;
    2) echo "$(printf "%.0f" "$usage")%$separator$speed" ;;
    3) echo "$speed" ;;
  esac
}

# Main Output logic
space_str=$(get_spacing)
value_str=$(get_value_string)

case $mode in
  1)  # Icon Mode
    echo -e "$icon$space_str$value_str"
    ;;
  2)  # Inline Text Mode
    echo -e "$textmode_title$space_str$value_str"
    ;;
  3)  # Breakline Text Mode
    echo -e "$textmode_title\n$value_str"
    ;;
  *)
    echo "Invalid mode selected"
    ;;
esac
