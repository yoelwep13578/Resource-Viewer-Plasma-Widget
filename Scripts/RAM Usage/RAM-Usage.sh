#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit Config Here

mode="1"                # [1] Icon Mode
                        # [2] Inline Text Mode
                        # [3] Breakline Text Mode

unit="1"                # [1] GB
                        # [2] GiB

show_as="1"             # [1] Percent
                        # [2] Percent + Size
                        # [3] Percent + Capacity
                        # [4] Size
                        # [5] Size + Capacity

separator=" | "         # Fill in with the separator of your choice

textmode_title="RAM:"   # Title in Text Mode
icon="\xEE\xBF\x85"     # Icon in Icon Mode (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)

spacing="1"             # Spacing between Icon/Title and Output



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

# Function to get RAM usage
get_ram_usage() {
    total_bytes=$(free -b | awk '/Mem:/ {print $2}')
    used_bytes=$(free -b | awk '/Mem:/ {print $3}')

    if [[ $unit == "1" ]]; then
        total=$(awk "BEGIN {printf \"%.1f\", $total_bytes/1000000000}")
        used=$(awk "BEGIN {printf \"%.1f\", $used_bytes/1000000000}")
        unit_label="GB"
    else
        total=$(awk "BEGIN {printf \"%.1f\", $total_bytes/1073741824}")
        used=$(awk "BEGIN {printf \"%.1f\", $used_bytes/1073741824}")
        unit_label="GiB"
    fi

    percent=$(awk "BEGIN {printf \"%.0f\", ($used_bytes/($total_bytes))*100}")

    case $show_as in
        1) output="${percent}%";;
        2) output="${percent}%${separator}${used}${unit_label}";;
        3) output="${percent}%${separator}${total}${unit_label}";;
        4) output="${used}${unit_label}";;
        5) output="${used}${unit_label}${separator}${total}${unit_label}";;
    esac

    echo "$output"
}

# Display RAM usage based on mode
display_output() {
    ram_usage=$(get_ram_usage)
    space_str=$(get_spacing)

    case $mode in
        1)
            # Icon Mode
            echo -e "${icon}${space_str}${ram_usage}"
            ;;
        2)
            # Inline Text Mode
            echo -e "${textmode_title}${space_str}${ram_usage}"
            ;;
        3)
            # Breakline Text Mode
            echo -e "${textmode_title}"
            echo "$ram_usage"
            ;;
    esac
}

# Execute the display function
display_output
