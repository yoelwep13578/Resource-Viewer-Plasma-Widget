#!/bin/bash

#===================
#  EDITABLE AREA
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

separator="|"           # Fill in with the separator of your choice

textmode_title="RAM: "  # Title in Text Mode



#===================================
#  NON-EDITABLE AREA. DEBUG ONLY!
#===================================

# Function to get RAM usage
get_ram_usage() {
    total_bytes=$(free -b | awk '/Mem:/ {print $2}') # Mengambil ukuran RAM dalam bytes
    used_bytes=$(free -b | awk '/Mem:/ {print $3}')  # Mengambil ukuran RAM yang terpakai dalam bytes

    if [[ $unit == "1" ]]; then
        # Convert to GB (Decimal system, 1 GB = 10^9 bytes)
        total=$(awk "BEGIN {printf \"%.1f\", $total_bytes/1000000000}")
        used=$(awk "BEGIN {printf \"%.1f\", $used_bytes/1000000000}")
        unit_label="GB"
    else
        # Convert to GiB (Binary system, 1 GiB = 2^30 bytes)
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

    echo $output
}

# Display RAM usage based on mode
display_output() {
    icon="\xEE\xBF\x85"  # Icon hexadecimal
    ram_usage=$(get_ram_usage)

    case $mode in
        1) echo -e "$icon $ram_usage";; # Icon Mode
        2) echo "${textmode_title}${ram_usage}";; # Inline Text Mode
        3) echo "${textmode_title}" # Breakline Text Mode
           echo "$ram_usage";;
    esac
}

# Execute the display function
display_output
