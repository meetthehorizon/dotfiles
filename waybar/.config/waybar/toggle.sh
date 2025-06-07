#!/bin/bash

CONFIG_DIR="$HOME/.config/waybar"
PIDFILE="/tmp/waybar.pid"

if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")" && rm "$PIDFILE"
else
    waybar -c "$CONFIG_DIR/config.jsonc" -s "$CONFIG_DIR/style.css" &
    echo $! >"$PIDFILE"
fi
