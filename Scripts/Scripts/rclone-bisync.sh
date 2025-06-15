#!/bin/bash

set -euo pipefail

# Set log directory (prefer XDG spec if user-space)
LOG_DIR="$HOME/.local/var/log/rclone-sync"
mkdir -p "$LOG_DIR"

# General log file
LOG_FILE="$LOG_DIR/sync.log"

# Rclone-specific log file (raw rclone output)
RCLONE_LOG="$LOG_DIR/rclone.log"

# Timestamp function
timestamp() {
    date "+[%Y-%m-%d %H:%M:%S]"
}

# Define source-destination pairs as a map-like array
declare -A SYNC_PATHS=(
    ["$HOME/Documents/conart"]="onedrive:Documents/conart"
    ["$HOME/Pictures"]="onedrive:Pictures"
    ["$HOME/Documents/Cryptomator"]="onedrive:Documents/Cryptomator"
    ["$HOME/.local/share/fonts"]="onedrive:Fonts"
    ["$HOME/Backup"]="onedrive:LinuxBackup"
)

# Function to sync a path pair
sync_path() {
    local src="$1"
    local dest="$2"

    echo "$(timestamp) Syncing: $src <-> $dest" | tee -a "$LOG_FILE"
    rclone bisync "$src" "$dest" --resync \
        --log-file="$RCLONE_LOG" \
        --log-level INFO \
        | while IFS= read -r line; do
            echo "$(timestamp) $line" | tee -a "$LOG_FILE"
          done
}

# Main loop
for src in "${!SYNC_PATHS[@]}"; do
    sync_path "$src" "${SYNC_PATHS[$src]}"
done

echo "$(timestamp) All paths synced successfully!" | tee -a "$LOG_FILE"

