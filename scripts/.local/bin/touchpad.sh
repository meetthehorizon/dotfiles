#!/bin/bash

DEVICE="asup1208:00-093a:3011-touchpad"
FLAG_FILE="/tmp/touchpad_disabled"

if [ -f "$FLAG_FILE" ]; then
    # Touchpad currently disabled → enable it
    hyprctl keyword "device[$DEVICE]:enabled" true
    rm "$FLAG_FILE"
    notify-send -u low "Touchpad Enabled"
else
    # Touchpad currently enabled → disable it
    hyprctl keyword "device[$DEVICE]:enabled" false
    touch "$FLAG_FILE"
    notify-send -u low "Touchpad Disabled"
fi
