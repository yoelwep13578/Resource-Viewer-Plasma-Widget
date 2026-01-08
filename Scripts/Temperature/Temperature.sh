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

separator=" | "               # Fill in with the separator of your choice

textmode_title="Temp:"      # Title in Text Mode

# Icons for each level (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)
icon_lvl1="\uf2cb"          # Cold / Idle
icon_lvl2="\uf2ca"          # Normal
icon_lvl3="\uf2c9"          # Warm
icon_lvl4="\uf2c7"          # Hot
icon_default="\uf2cb"       # Default < level1

spacing="1"                 # Spacing between Icon/Title and Output

target="allCPU"             # "allCPU" for CPU Package 0
                            # "overall" for acpitz-acpi-0
                            # Write number for specific core (e.g. "0" for core 0)

# Limit & Details. Fill with:
# [Limit in Celsius], [Limit in Fahrenheit], [Detail text]
#
# Example:  level1_limit=(40 104 "Chill")
#   Celcius───────────────┘   │    └─────────Detail Text
#                        Fahrenheit

level1_limit=(40 104 "Idle")
level2_limit=(50 122 "Normal")
level3_limit=(72 162 "Warm")
level4_limit=(85 185 "Hot")



#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

# Function to get/create spacing
get_spacing() {
  # Check if spacing value is positive
  if [[ "$spacing" =~ ^[0-9]+$ ]]; then
    printf "%${spacing}s" ""
  else
    printf ""
  fi
}

# Function to convert Celsius to Fahrenheit
convert_to_fahrenheit() {
  local celsius=$1
  echo $(( ($celsius * 9/5) + 32 ))
}

# Function to get temperature for target
get_temp() {
  if [[ "$target" == "allCPU" ]]; then
    sensors | grep -i 'Package id 0' | awk '{gsub(/\+/, "", $4); printf "%d", $4}'
  elif [[ "$target" == "overall" ]]; then
    sensors acpitz-acpi-0 | awk -F'[+:]' '/temp1/ {print $3}' | awk '{printf "%d", $1}'
  else
    sensors | grep -i "Core $target" | awk '{gsub(/\+/, "", $3); printf "%d", $3}'
  fi
}

# Function to determine icon and detail based on temperature
get_icon_and_detail() {
  local temp=$1
  local icon=""
  local detail=""

  if [ "$unit" == "F" ]; then
    local check_temp=$(convert_to_fahrenheit "$temp")
    limit1=${level1_limit[1]}
    limit2=${level2_limit[1]}
    limit3=${level3_limit[1]}
    limit4=${level4_limit[1]}
  else
    local check_temp=$temp
    limit1=${level1_limit[0]}
    limit2=${level2_limit[0]}
    limit3=${level3_limit[0]}
    limit4=${level4_limit[0]}
  fi

  if [ "$check_temp" -ge "$limit4" ]; then
    icon="$icon_lvl4"
    detail="${level4_limit[2]}"
  elif [ "$check_temp" -ge "$limit3" ]; then
    icon="$icon_lvl3"
    detail="${level3_limit[2]}"
  elif [ "$check_temp" -ge "$limit2" ]; then
    icon="$icon_lvl2"
    detail="${level2_limit[2]}"
  elif [ "$check_temp" -ge "$limit1" ]; then
    icon="$icon_lvl1"
    detail="${level1_limit[2]}"
  else
    icon="$icon_default"
    detail="${level1_limit[2]}"
  fi

  echo "$icon|$detail|$temp"
}

# Function to format and display
get_temperature_display() {
  local raw_temp=$(get_temp)
  local temp_info=$(get_icon_and_detail "$raw_temp")

  local icon=$(echo "$temp_info" | cut -d'|' -f1)
  local detail=$(echo "$temp_info" | cut -d'|' -f2)
  local temp_val=$(echo "$temp_info" | cut -d'|' -f3)

  # Count value (C/F) for output
  if [ "$unit" == "F" ]; then
      display_val=$(convert_to_fahrenheit "$temp_val")
  else
      display_val="$temp_val"
  fi

  case $show_as in
    1) result="${display_val}°${unit}" ;;
    2) result="${display_val}°${unit}${separator}${detail}" ;;
  esac

  local space_str=$(get_spacing)

  case $mode in
    1) echo -e "${icon}${space_str}${result}" ;;
    2) echo -e "${textmode_title}${space_str}${result}" ;;
    3) echo -e "${textmode_title}\n${result}" ;;
  esac
}

get_temperature_display
