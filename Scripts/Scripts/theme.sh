#!/bin/bash

# Directories
STATIC_DIR="$HOME/Pictures/Wallpapers"
GIF_DIR="$HOME/Pictures/Wallpapers(GIF)"
CACHE_WALL="$HOME/.cache/wallpaper"

# Select mode
if [ "$1" == "0" ]; then
    DIR="$STATIC_DIR"
elif [ "$1" == "1" ]; then
    DIR="$GIF_DIR"
else
    echo "Usage: $0 [0 for static wallpapers | 1 for GIF wallpapers]"
    exit 1
fi

# Pick random wallpaper
WALL=$(find "$DIR" -type f | shuf -n 1)

# Generate colors using wal
wal -i "$WALL"

# Set wallpaper using swww
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 144

# If static, link to .cache/wallpaper
if [ "$1" == "0" ]; then
    ln -sf "$WALL" "$CACHE_WALL"
fi

# Reload waybar
~/.config/waybar/toggle.sh
~/.config/waybar/toggle.sh
