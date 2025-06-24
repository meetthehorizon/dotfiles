#!/usr/bin/env bash

# --- Mode handling ---
MODE="$1"

if [[ "$MODE" == "0" ]]; then
    WALL_DIR="$HOME/Pictures/Wallpapers"
elif [[ "$MODE" == "1" ]]; then
    WALL_DIR="$HOME/Pictures/Wallpapers GIF"
else
    echo "Usage: $0 <mode>"
    echo "  mode 0 = static wallpapers"
    echo "  mode 1 = GIF wallpapers"
    exit 1
fi

# --- Check directory ---
if [[ ! -d "$WALL_DIR" ]]; then
    echo "❌ Error: Directory '$WALL_DIR' does not exist."
    exit 1
fi

# --- Get current wallpaper (resolved symlink) ---
CURRENT="$(readlink -f "$HOME/.cache/wallpaper")"

# --- Pick a new random wallpaper (not the current one) ---
while true; do
    WALL=$(find "$WALL_DIR" -type f | shuf -n 1)
    if [[ "$(readlink -f "$WALL")" != "$CURRENT" ]]; then
        break
    fi
done

# --- Create symlink to ~/.cache/wallpaper ---
CACHE_LINK="$HOME/.cache/wallpaper"
ln -sf "$WALL" "$CACHE_LINK"

# --- Generate Pywal colors ---
wal -i "$WALL"

# --- Set wallpaper using swww ---
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 144

# --- Reload eww and Waybar ---
eww reload
~/.config/waybar/toggle.sh
~/.config/waybar/toggle.sh
