#!/bin/bash

# Directories
STATIC_DIR="$HOME/Pictures/wallpapers-pc"
GIF_DIR="$HOME/Pictures/wallpapers-pc-gif"
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

# Set wallpaper using swww
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 120

# If static, link to .cache/wallpaper
if [ "$1" == "0" ]; then
    ln -sf "$WALL" "$CACHE_WALL"
fi