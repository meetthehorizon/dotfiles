#!/bin/bash
# Max brightness
MAX=3
MIN=0

# Path to brightness file
BRIGHT_FILE="/sys/class/leds/asus::kbd_backlight/brightness"

# Read current brightness
CURRENT=$(cat "$BRIGHT_FILE")

# Determine new brightness
case "$1" in
    higher)
        if (( CURRENT < MAX )); then
            NEXT=$((CURRENT + 1))
        else
            exit 0
        fi
    ;;
    lower)
        if (( CURRENT > MIN )); then
            NEXT=$((CURRENT - 1))
        else
            exit 0
        fi
    ;;
    *)
        echo "Usage: $0 {higher|lower}"
        exit 1
    ;;
esac

# Map number to asusctl keyword
case $NEXT in
    0) LEVEL="off" ;;
    1) LEVEL="low" ;;
    2) LEVEL="med" ;;
    3) LEVEL="high" ;;
esac

# Set brightness via asusctl
asusctl -k "$LEVEL"
