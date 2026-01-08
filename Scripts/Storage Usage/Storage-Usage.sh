#!/bin/bash

#===================
#  EDITABLE ZONE
#===================

# Edit config here

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

textmode_title="Storage:"  # Title in Text Mode
icon="\uf1c0"           # Icon in Icon Mode (Nerd Font Icon Code, Exact Nerd Font Icon, Emoji, etc)

spacing="1"             # Spacing between Icon/Title and Output

target="overall"        # Target to all mounted partitions --> use "overall"
                        # Target to mounted partition --> write like "/dev/sda5"

dynamic_conversion="1"  # [1] Enable dynamic conversion (KB/MiB/GB/TiB)
                        # [0] Disable dynamic conversion, stick to GB/GiB



#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

# Function to get/create spacing
get_spacing() {
    # Check if spacing value is positive
    if [[ "$spacing" =~ ^[0-9]+$ ]]; then
        printf "%${spacing}s" ""
    else
        printf "" # Fallback to 0 if invalid/minus
    fi
}

# Function to convert bytes to appropriate unit based on dynamic_conversion
convert_bytes() {
    local bytes=$1
    local unit=$2
    local output

    if [[ $dynamic_conversion == "1" ]]; then
        case $unit in
            "GB")
                if (( bytes >= 1000000000000 )); then
                    output=$(awk "BEGIN {printf \"%.1fTB\", $bytes/1000000000000}")
                elif (( bytes >= 1000000000 )); then
                    output=$(awk "BEGIN {printf \"%.1fGB\", $bytes/1000000000}")
                elif (( bytes >= 1000000 && bytes < 1000000000 )); then
                    output=$(awk "BEGIN {printf \"%.1fMB\", $bytes/1000000}")
                else
                    output=$(awk "BEGIN {printf \"%.0fKB\", $bytes/1000}")
                fi
                ;;
            "GiB")
                if (( bytes >= 1099511627776 )); then
                    output=$(awk "BEGIN {printf \"%.1fTiB\", $bytes/1099511627776}")
                elif (( bytes >= 1073741824 )); then
                    output=$(awk "BEGIN {printf \"%.1fGiB\", $bytes/1073741824}")
                elif (( bytes >= 1048576 && bytes < 1073741824 )); then
                    output=$(awk "BEGIN {printf \"%.1fMiB\", $bytes/1048576}")
                else
                    output=$(awk "BEGIN {printf \"%.0fKiB\", $bytes/1024}")
                fi
                ;;
        esac
    else
        case $unit in
            "GB") output=$(awk "BEGIN {printf \"%.1fGB\", $bytes/1000000000}") ;;
            "GiB") output=$(awk "BEGIN {printf \"%.1fGiB\", $bytes/1073741824}") ;;
        esac
    fi
    echo "$output"
}

# Function to get storage usage
get_storage_usage() {
    if [[ $target == "overall" || $target =~ ^[Oo][Vv][Ee][Rr][Aa][Ll]$ ]]; then
        total=$(df -B1 --total | awk '/total/ {print $2}')
        used=$(df -B1 --total | awk '/total/ {print $3}')
        percent=$(df --total | awk '/total/ {print $5}' | sed 's/%//')
    else
        total=$(df -B1 "$target" | awk 'NR==2 {print $2}')
        used=$(df -B1 "$target" | awk 'NR==2 {print $3}')
        percent=$(df "$target" | awk 'NR==2 {print $5}' | sed 's/%//')
    fi

    if [[ $unit == "1" ]]; then
        total=$(convert_bytes "$total" "GB")
        used=$(convert_bytes "$used" "GB")
    else
        total=$(convert_bytes "$total" "GiB")
        used=$(convert_bytes "$used" "GiB")
    fi

    case $show_as in
        1) output="${percent}%";;
        2) output="${percent}%${separator}${used}";;
        3) output="${percent}%${separator}${total}";;
        4) output="${used}";;
        5) output="${used}${separator}${total}";;
    esac
    echo "$output"
}

# Display storage usage based on mode
display_output() {
    storage_usage=$(get_storage_usage)
    space_str=$(get_spacing)

    case $mode in
        1)
            # Icon Mode
            echo -e "${icon}${space_str}${storage_usage}"
            ;;
        2)
            # Inline Text Mode
            echo -e "${textmode_title}${space_str}${storage_usage}"
            ;;
        3)
            # Breakline Text Mode
            echo -e "${textmode_title}"
            echo "$storage_usage"
            ;;
    esac
}

# Execute the display function
display_output
