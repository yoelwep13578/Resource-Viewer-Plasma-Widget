#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit config here
mode="1"                    # [1] Icon Mode
                            # [2] Inline Text Mode
                            # [3] Breakline Text Mode

unit="C"                    # "C" for Celsius
                            # "F" for Fahrenheit

show_as="1"                 # [1] Temp
                            # [2] Temp + Detail

separator="|"               # Fill in with the separator of your choice

textmode_title="Temp: "     # Title in Text Mode

target="allCPU"             # "allCPU" for CPU Package 0
                            # "overall" for acpitz-acpi-0
                            # Write number for specific core (e.g. "0" for core 0)

# Limit & Details. Fill with:
# [Limit in Celsius], [Limit in Fahrenheit], [Detail text]

level1_limit=(40 104 "Idle")
level2_limit=(50 122 "Normal")
level3_limit=(72 162 "Warm")
level4_limit=(85 185 "Hot")



#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

# Function to convert Celsius to Fahrenheit
convert_to_fahrenheit() {
  local celsius=$1
  echo $(( ($celsius * 9/5) + 32 ))
}

# Function to get temperature for target
get_temp() {
  if [[ "$target" == "allCPU" ]]; then
    # Get overall CPU temp (Package id 0)
    sensors | grep -i 'Package id 0' | awk '{gsub(/\+/, "", $4); printf "%d", $4}'
  elif [[ "$target" == "overall" ]]; then
    # Get overall system temp (acpitz-acpi-0)
    sensors acpitz-acpi-0 | awk -F'[+:]' '/temp1/ {print $3}' | awk '{printf "%d", $1}'
  else
    # Get specific core temp (e.g., core 0)
    sensors | grep -i "Core $target" | awk '{gsub(/\+/, "", $3); printf "%d", $3}'
  fi
}

# Function to determine icon and detail based on temperature
get_icon_and_detail() {
  local temp=$1
  local icon=""
  local detail=""

  # Set the limits based on unit (Celsius or Fahrenheit)
  if [ "$unit" == "F" ]; then
    temp=$(convert_to_fahrenheit "$temp")
    limit1=${level1_limit[1]}
    limit2=${level2_limit[1]}
    limit3=${level3_limit[1]}
    limit4=${level4_limit[1]}
  else
    limit1=${level1_limit[0]}
    limit2=${level2_limit[0]}
    limit3=${level3_limit[0]}
    limit4=${level4_limit[0]}
  fi

  # Determine icon and detail based on temp levels
  if [ "$temp" -ge "$limit4" ]; then
    icon="\uf2c7"
    detail="${level4_limit[2]}"
  elif [ "$temp" -ge "$limit3" ]; then
    icon="\uf2c9"
    detail="${level3_limit[2]}"
  elif [ "$temp" -ge "$limit2" ]; then
    icon="\uf2ca"
    detail="${level2_limit[2]}"
  elif [ "$temp" -ge "$limit1" ]; then
    icon="\uf2cb"
    detail="${level1_limit[2]}"
  else
    icon="\uf2cb"
    detail="${level1_limit[2]}"
  fi

  # Return icon, detail, and temperature with unit
  echo "$icon|$detail|$temp°$unit"
}

# Function to get temperature and format it based on mode
get_temperature_display() {
  local temp=$(get_temp)
  local temp_info=$(get_icon_and_detail "$temp")
  local icon=$(echo "$temp_info" | cut -d'|' -f1)
  local detail=$(echo "$temp_info" | cut -d'|' -f2)
  local formatted_temp=$(echo "$temp_info" | cut -d'|' -f3)

  case $show_as in
    1)  # Temp only
      result="$formatted_temp"
      ;;
    2)  # Temp + Detail
      result="$formatted_temp$separator$detail"
      ;;
  esac

  # Output based on mode
  case $mode in
    1)  # Icon Mode
      echo -e "$icon $result"
      ;;
    2)  # Inline Text Mode
      echo "$textmode_title$result"
      ;;
    3)  # Breakline Text Mode
      echo -e "$textmode_title\n$result"
      ;;
    *)
      echo "Invalid mode selected"
      ;;
  esac
}

# Execute the function to get the temperature display
get_temperature_display
