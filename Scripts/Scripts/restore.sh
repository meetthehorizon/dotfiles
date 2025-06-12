#!/bin/bash

# Find latest backup directory
latest_backup=$(ls -1dt "$HOME/Backup"/* | head -n 1)

pkglist="$latest_backup/pkglist.txt"
aurlist="$latest_backup/aur-pkglist.txt"

# Check for existence
if [[ ! -f "$pkglist" || ! -f "$aurlist" ]]; then
    echo "❌ Backup files not found in $latest_backup"
    exit 1
fi

echo "🔄 Restoring from: $latest_backup"

# Restore pacman packages
echo "📦 Installing official packages..."
sudo pacman -Syu --needed - <"$pkglist"

# Ensure paru is installed
if ! command -v paru &>/dev/null; then
    echo "⚙️  paru not found. Installing paru..."
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmpdir"
    pushd "$tmpdir" || exit 1
    makepkg -si --noconfirm
    popd
    rm -rf "$tmpdir"
else
    echo "✅ paru already installed"
fi

# Restore AUR packages
echo "📦 Installing AUR packages..."
paru -S --needed - <"$aurlist"

echo "✅ Restore complete."
