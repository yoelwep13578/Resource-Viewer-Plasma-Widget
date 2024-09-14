#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                  # [1] Icon Mode
                          # [2] Inline Text Mode
                          # [3] Breakline Text Mode

textmode_title="Disk: "   # Title for text mode

target="/dev/sda"         # Target disk, default is /dev/sda



#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

# Function to get disk usage
get_disk_usage() {
  iostat -dx "$target" 1 2 | tail -n +7 | awk '/sda/ {
    usage = int($(NF-1))  # Convert to Integer
    print usage  # Return only usage percentage
  }'
}

# Function to get icon based on usage
get_icon() {
  usage=$(get_disk_usage)
  if [ "$usage" -le 10 ]; then
    echo -e "\uE271 $usage%"
  else
    echo -e "\uEDE9 $usage%"
  fi
}

# Output based on mode
case $mode in
  1)  # Icon Mode
    get_icon
    ;;
  2)  # Inline Text Mode
    echo "$textmode_title$(get_disk_usage)%"
    ;;
  3)  # Breakline Text Mode
    echo -e "$textmode_title\n$(get_disk_usage)%"
    ;;
  *)
    echo "Invalid mode selected"
    ;;
esac
