#!/usr/bin/env bash

# Pick a random wallpaper from Wallpapers directory
WALL=$(find ~/Pictures/Wallpapers -type f | shuf -n 1)

# Generate a Pywal color scheme
wal -i "$WALL"

# Actually set the wallpaper with a transition
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 144

# Reload the eww daemon to apply changes
eww reload

# Restart waybar
if pgrep -x waybar >/dev/null; then
    killall waybar
    waybar &
else
    waybar &
fi
