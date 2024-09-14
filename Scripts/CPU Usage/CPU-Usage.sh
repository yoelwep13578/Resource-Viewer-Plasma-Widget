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

separator="|"              # Fill in with the separator of your choice

textmode_title="CPU: "     # Title in Text Mode

target="overall"           # "overall" for all cores, or specific core (e.g. "1" for core 1)
                           # Remember: core always start from 0, not from 1.



#====================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#====================================

# Function to get CPU usage for overall or specific core
get_cpu_usage() {
  if [[ $target == "overall" ]]; then
    # Overall CPU usage
    top -bn1 | grep "Cpu(s)" | awk '{usage=100-$8} END {print usage}'
  else
    # CPU usage for specific core using mpstat
    mpstat -P "$target" 1 1 | awk -v core="$target" '
    BEGIN {idle_col=13}
    $3 == core {idle=$idle_col}
    END {print 100-idle}
    '
  fi
}

# Function to get current CPU speed for overall or specific core
get_cpu_speed() {
  if [[ $target == "overall" ]]; then
    cat /proc/cpuinfo | grep "MHz" | awk 'NR==1 {printf "%.1fGHz", $4/1000}'
  else
    # Specific core speed from sysfs
    freq_path="/sys/devices/system/cpu/cpu$target/cpufreq/scaling_cur_freq"
    if [[ -f "$freq_path" ]]; then
      freq=$(cat "$freq_path")
      echo "$(awk "BEGIN {printf \"%.1fGHz\", $freq/1000000}")"
    else
      echo "N/A"
    fi
  fi
}

# Function to output with icon or text
get_icon() {
  usage=$(get_cpu_usage)
  speed=$(get_cpu_speed)

  case $show_as in
    1)  # Percent
      echo -e "\uf4bc $(printf "%.0f" "$usage")%"
      ;;
    2)  # Percent + Current Speed
      echo -e "\uf4bc $(printf "%.0f" "$usage")%$separator$speed"
      ;;
    3)  # Current Speed
      echo -e "\uf4bc $speed"
      ;;
  esac
}

# Output based on mode
case $mode in
  1)  # Icon Mode
    get_icon
    ;;
  2)  # Inline Text Mode
    case $show_as in
      1) echo "$textmode_title$(printf "%.0f" "$(get_cpu_usage)")%" ;;
      2) echo "$textmode_title$(printf "%.0f" "$(get_cpu_usage)")%$separator$(get_cpu_speed)" ;;
      3) echo "$textmode_title$(get_cpu_speed)" ;;
    esac
    ;;
  3)  # Breakline Text Mode
    case $show_as in
      1) echo -e "$textmode_title\n$(printf "%.0f" "$(get_cpu_usage)")%" ;;
      2) echo -e "$textmode_title\n$(printf "%.0f" "$(get_cpu_usage)")%$separator$(get_cpu_speed)" ;;
      3) echo -e "$textmode_title\n$(get_cpu_speed)" ;;
    esac
    ;;
  *)
    echo "Invalid mode selected"
    ;;
esac
