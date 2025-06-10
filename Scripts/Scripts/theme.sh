#!/usr/bin/env bash

# Pick a random wallpaper
WALL=$(find ~/Pictures/Wallpapers -type f | shuf -n 1)

# Symlink it to ~/.cache/wallpaper
CACHE_LINK="$HOME/.cache/wallpaper"
ln -sf "$WALL" "$CACHE_LINK"

# Generate a Pywal color scheme from the symlink
wal -i "$WALL"

# Set the wallpaper with transition using the symlink
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 144

# Reload the eww daemon to apply changes
eww reload

# Restart Waybar via toggle (off-on)
~/.config/waybar/toggle.sh
~/.config/waybar/toggle.sh
