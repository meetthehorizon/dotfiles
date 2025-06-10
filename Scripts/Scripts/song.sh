#!/bin/bash

# Get data from playerctl
artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
position=$(playerctl position)
duration=$(playerctl metadata mpris:length) # in microseconds

if [ -z "$artist" ]; then
    echo "Nothing Playing"
    exit
fi

# Convert duration from µs to seconds
duration_sec=$((duration / 1000000))
position_sec=$(printf "%.0f\n" "$position")

# Calculate progress bar
bar_width=20
filled=$((position_sec * bar_width / duration_sec))
bar=$(printf "%-${bar_width}s" | tr ' ' '-')
bar="${bar:0:$filled}$(printf "%-${bar_width}s" | tr ' ' '-')"

# Format output
echo "$artist - $title"
echo "$bar"
