#!/bin/bash

set -euo pipefail

# Define source-destination pairs as a map-like array
declare -A SYNC_PATHS=(
    ["$HOME/Documents/conart"]="onedrive:Documents/conart"
    ["$HOME/Pictures"]="onedrive:Pictures"
    ["$HOME/Documents/Cryptomator"]="onedrive:Documents/Cryptomator"
    ["$HOME/.local/share/fonts"]="onedrive:Fonts"
    ["$HOME/Backup"]="onedrive:LinuxBackup"
)

# Optional: Set logging
LOG_FILE="$HOME/rclone_sync.log"

# Function to sync a path pair
sync_path() {
    local src="$1"
    local dest="$2"

    echo "Syncing: $src <-> $dest" | tee -a "$LOG_FILE"
    rclone bisync "$src" "$dest" --resync | tee -a "$LOG_FILE"
}

# Main loop
for src in "${!SYNC_PATHS[@]}"; do
    sync_path "$src" "${SYNC_PATHS[$src]}"
done

echo "All paths synced successfully!" | tee -a "$LOG_FILE"
