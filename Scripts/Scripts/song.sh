#!/bin/bash

# Check if playerctl is running
if ! playerctl status &>/dev/null; then
    echo "Nothing Playing"
    exit
fi

# Fetch metadata
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
position=$(playerctl position 2>/dev/null)
duration=$(playerctl metadata mpris:length 2>/dev/null) # in microseconds

# Sanity checks
if [ -z "$artist" ] || [ -z "$title" ] || [ -z "$position" ] || [ -z "$duration" ]; then
    echo "Nothing Playing"
    exit
fi

# Convert to seconds
duration_sec=$((duration / 1000000))
position_sec=$(printf "%.0f" "$position")

# Format time
format_time() {
    local T=$1
    printf "%02d:%02d" $((T / 60)) $((T % 60))
}

# Build progress bar with symbols
bar_width=20
filled=$((position_sec * bar_width / duration_sec))
empty=$((bar_width - filled))

bar=""
if ((filled > 0)); then
    bar+=$(printf '%.0s' $(seq 1 $filled))
fi
if ((empty > 0)); then
    bar+=$(printf '%.0s' $(seq 1 $empty))
fi

# Output
echo "$artist   $title"
echo "$(format_time "$position_sec") / $(format_time "$duration_sec")"
echo "[$bar ]"
