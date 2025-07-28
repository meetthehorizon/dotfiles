#!/bin/bash

# Config
max_length=30 # Max combined length of "artist  title" before trimming
bar_width=20
total_width=50 # Total width of the final output for center alignment

# Check if playerctl is running
if ! playerctl status &>/dev/null; then
    echo "Nothing Playing" | awk -v width="$total_width" '{ printf "%*s\n", int((width + length($0)) / 2), $0 }'
    exit
fi

# Fetch metadata
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
position=$(playerctl position 2>/dev/null)
duration=$(playerctl metadata mpris:length 2>/dev/null) # microseconds

# Sanity checks
if [ -z "$artist" ] || [ -z "$title" ] || [ -z "$position" ] || [ -z "$duration" ]; then
    echo "Nothing Playing" | awk -v width="$total_width" '{ printf "%*s\n", int((width + length($0)) / 2), $0 }'
    exit
fi

# Convert times
duration_sec=$((duration / 1000000))
position_sec=$(printf "%.0f" "$position")

# Format time function
format_time() {
    local T=$1
    printf "%02d:%02d" $((T / 60)) $((T % 60))
}

# Build progress bar
filled=$((position_sec * bar_width / duration_sec))
empty=$((bar_width - filled))

bar=""
if ((filled > 0)); then
    bar+=$(printf '%.0s' $(seq 1 $filled))
fi
if ((empty > 0)); then
    bar+=$(printf '%.0s' $(seq 1 $empty))
fi

# Trim artist/title if too long
display_text="$artist  $title"
if [ ${#display_text} -gt $max_length ]; then
    display_text="${display_text:0:$((max_length - 3))}..."
fi

# Output Centered
printf "%*s\n" $(((total_width + ${#display_text}) / 2)) "$display_text"
time_info="$(format_time "$position_sec") / $(format_time "$duration_sec")"
printf "%*s\n" $(((total_width + ${#time_info}) / 2)) "$time_info"
printf "%*s\n" $(((total_width + ${#bar} + 2) / 2)) "[$bar ]"
