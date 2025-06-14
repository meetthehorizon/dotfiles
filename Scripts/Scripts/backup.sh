#!/bin/bash

# Timestamped backup directory
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="$HOME/Backup/$timestamp"
mkdir -p "$backup_dir"

# Save package lists
pacman -Qqe >"$backup_dir/pkglist.txt"
paru -Qqe >"$backup_dir/aur-pkglist.txt"

echo "✔ Package lists saved to $backup_dir"

# Keep only the latest 5 backups
cd "$HOME/Backup" || exit 1
ls -1dt */ | tail -n +6 | xargs -r rm -rf

echo "✔ Old backups pruned (only latest 5 kept)"
