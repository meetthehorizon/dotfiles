#!/bin/bash

set -euo pipefail

# Rclone-specific log file (raw rclone output)
RCLONE_LOG="$HOME/.local/var/log/rclone-sync/rclone.log"
mkdir -p "$(dirname "$RCLONE_LOG")"

# Timestamp function
timestamp() {
    date "+[%Y-%m-%d %H:%M:%S]"
}

# Source-Destination Map
declare -A SYNC_PATHS=(
    ["$HOME/Documents/conart"]="onedrive:Documents/conart"
    ["$HOME/Pictures"]="onedrive:Pictures"
    ["$HOME/Documents/Cryptomator"]="onedrive:Documents/Cryptomator"
    ["$HOME/.local/share/fonts"]="onedrive:Fonts"
)

# Sync function
sync_path() {
    local src="$1"
    local dest="$2"
    
    echo "$(timestamp) Syncing: $src <-> $dest"
    rclone bisync "$src" "$dest" --verbose --log-file="$RCLONE_LOG"
}

# Main loop
for src in "${!SYNC_PATHS[@]}"; do
    sync_path "$src" "${SYNC_PATHS[$src]}"
done

echo "$(timestamp) All paths synced successfully!"
