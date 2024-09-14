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

separator="|"           # Fill in with the separator of your choice

textmode_title="Storage: "  # Title in Text Mode

target="overall"        # Target to all mounted partitions --> use "overall"
                        # Target to disk --> write like "/dev/sda"
                        # Target to partition -> write like "/dev/sda5"

dynamic_conversion="1"  # [1] Enable dynamic conversion (KB/MiB/GB/TiB)
                        # [0] Disable dynamic conversion, stick to GB/GiB


#===================================
#  NON-EDITABLE ZONE. DEBUG ONLY!
#===================================

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
                    output=$(awk "BEGIN {printf \"%.0fKB\", $bytes/1000}") # No decimals for KB
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
                    output=$(awk "BEGIN {printf \"%.0fKiB\", $bytes/1024}") # No decimals for KiB
                fi
                ;;
        esac
    else
        # Static conversion, stick to GB or GiB
        case $unit in
            "GB")
                output=$(awk "BEGIN {printf \"%.1fGB\", $bytes/1000000000}")
                ;;
            "GiB")
                output=$(awk "BEGIN {printf \"%.1fGiB\", $bytes/1073741824}")
                ;;
        esac
    fi

    echo $output
}

# Function to get storage usage
get_storage_usage() {
    if [[ $target == "overall" || $target =~ ^[Oo][Vv][Ee][Rr][Aa][Ll]$ ]]; then
        # Overall storage usage
        total=$(df -B1 --total | awk '/total/ {print $2}')   # Total storage in bytes
        used=$(df -B1 --total | awk '/total/ {print $3}')    # Used storage in bytes
        percent=$(df --total | awk '/total/ {print $5}' | sed 's/%//')
    else
        # Specific target storage usage
        total=$(df -B1 $target | awk 'NR==2 {print $2}')   # Total storage in bytes
        used=$(df -B1 $target | awk 'NR==2 {print $3}')    # Used storage in bytes
        percent=$(df $target | awk 'NR==2 {print $5}' | sed 's/%//')
    fi

    if [[ $unit == "1" ]]; then
        # Convert to GB or dynamic conversion in decimal
        total=$(convert_bytes $total "GB")
        used=$(convert_bytes $used "GB")
        unit_label="GB"
    else
        # Convert to GiB or dynamic conversion in binary
        total=$(convert_bytes $total "GiB")
        used=$(convert_bytes $used "GiB")
        unit_label="GiB"
    fi

    case $show_as in
        1) output="${percent}%";;
        2) output="${percent}%${separator}${used}";;
        3) output="${percent}%${separator}${total}";;
        4) output="${used}";;
        5) output="${used}${separator}${total}";;
    esac

    echo $output
}

# Display storage usage based on mode
display_output() {
    icon="\uf1c0"  # Icon hexadecimal
    storage_usage=$(get_storage_usage)

    case $mode in
        1) echo -e "$icon $storage_usage";; # Icon Mode
        2) echo "${textmode_title}${storage_usage}";; # Inline Text Mode
        3) echo "${textmode_title}" # Breakline Text Mode
           echo "$storage_usage";;
    esac
}

# Execute the display function
display_output
