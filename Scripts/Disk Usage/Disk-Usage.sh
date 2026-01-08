#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                  # [1] Icon Mode
                          # [2] Inline Text Mode
                          # [3] Breakline Text Mode

textmode_title="Disk:"    # Title for text mode
icon_idle="\uE271"        # Icon for <= threshold (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)
icon_active="\uEDE9"      # Icon for > threshold  (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)

spacing="1"               # Spacing between Icon/Title and Output

target="/dev/sda"         # Target disk, default is /dev/sda

threshold="10"            # Threshold for switching icon when idle and active (0-100)


#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

# Function to get/create spacing
get_spacing() {
    if [[ "$spacing" =~ ^[0-9]+$ ]]; then
        printf "%${spacing}s" ""
    else
        printf "" # Fallback to 0 if invalid/minus
    fi
}

# Function to validate threshold
get_threshold() {
    # Check is threshold value 0-100
    if [[ "$threshold" =~ ^[0-9]+$ ]] && [ "$threshold" -ge 0 ] && [ "$threshold" -le 100 ]; then
        echo "$threshold"
    else
        echo "10" # Fallback to 10 (10%)
    fi
}

# Function to get disk usage
get_disk_usage() {
    # Getting disk usage value on %util column
    iostat -dx "$target" 1 2 | tail -n +7 | awk -v disk="$(basename $target)" '$0 ~ disk {
        usage = int($(NF))
        print usage
    }' | tail -n 1
}

# Additional variable
usage=$(get_disk_usage)
space_str=$(get_spacing)
limit=$(get_threshold)

case $mode in
  1)  # Icon Mode
    if [ "$usage" -ge "$limit" ]; then
      current_icon="$icon_active"
    else
      current_icon="$icon_idle"
    fi
    echo -e "${current_icon}${space_str}${usage}%"
    ;;
  2)  # Inline Text Mode
    echo -e "${textmode_title}${space_str}${usage}%"
    ;;
  3)  # Breakline Text Mode
    echo -e "${textmode_title}"
    echo "${usage}%"
    ;;
  *)
    echo "Invalid mode selected"
    ;;
esac
