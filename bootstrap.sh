#!/bin/bash

set -euo pipefail

# -------------------------
# Default values
# -------------------------
DEFAULT_USER="conart"
DEFAULT_REPO="https://github.com/meetthehorizon/dotfiles.git"
DEFAULT_DOTFILES_DIR="/home/${DEFAULT_USER}/dotfiles"
DEFAULT_SHELL="/bin/zsh"

# -------------------------
# Parse arguments
# -------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
  --user)
    USERNAME="$2"
    shift 2
    ;;
  --repo)
    DOTFILES_REPO="$2"
    shift 2
    ;;
  --dotfiles-dir)
    DOTFILES_DIR="$2"
    shift 2
    ;;
  --shell)
    USER_SHELL="$2"
    shift 2
    ;;
  *)
    echo "❌ Unknown option $1"
    exit 1
    ;;
  esac
done

# -------------------------
# Apply defaults
# -------------------------
USERNAME="${USERNAME:-$DEFAULT_USER}"
DOTFILES_REPO="${DOTFILES_REPO:-$DEFAULT_REPO}"
DOTFILES_DIR="${DOTFILES_DIR:-/home/$USERNAME/dotfiles}"
USER_SHELL="${USER_SHELL:-$DEFAULT_SHELL}"
PARU_REPO="https://aur.archlinux.org/paru.git"

# -------------------------
# Ensure root
# -------------------------
if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run as root (e.g. sudo ./bootstrap.sh)"
  exit 1
fi

# -------------------------
# Base system setup
# -------------------------
echo "📦 Updating system..."
pacman -Syu --noconfirm
pacman -S --needed git stow sudo base-devel zsh --noconfirm

# -------------------------
# User creation
# -------------------------
if ! id "$USERNAME" &>/dev/null; then
  echo "👤 Creating user $USERNAME..."
  useradd -m -G wheel -s "$USER_SHELL" "$USERNAME"
  echo "$USERNAME:password" | chpasswd
else
  echo "👤 User $USERNAME already exists, skipping creation."
fi

# -------------------------
# Enable sudo for wheel
# -------------------------
if ! grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
  echo "🛡 Enabling sudo for wheel group..."
  sed -i '/^# %wheel ALL=(ALL:ALL) ALL/s/^# //' /etc/sudoers
fi

# -------------------------
# Run user setup
# -------------------------
sudo -u "$USERNAME" bash <<EOF
set -e

# Clone dotfiles
if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "📁 Dotfiles already exist. Pulling updates..."
  cd "$DOTFILES_DIR" && git pull
fi

cd "$DOTFILES_DIR"
stow */

# Install paru
if ! command -v paru &>/dev/null; then
  echo "📦 Installing paru (AUR helper)..."
  git clone "$PARU_REPO" ~/paru
  cd ~/paru
  makepkg -si --noconfirm
  cd ~
fi

# Install packages
[[ -f "$DOTFILES_DIR/pkglist.txt" ]] && sudo pacman -S --needed - < "$DOTFILES_DIR/pkglist.txt"
[[ -f "$DOTFILES_DIR/aurlist.txt" ]] && xargs paru -S --needed < "$DOTFILES_DIR/aurlist.txt"

# ZSH goodies
paru -S --noconfirm zsh-autosuggestions zsh-syntax-highlighting

ZSHRC=~/.zshrc

echo "⚙️ Setting up Zsh config..."

# Basic zshrc entries
{
  echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  echo "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'"
  echo "bindkey '^ ' autosuggest-accept"
} >> "\$ZSHRC"

# Set shell
chsh -s "$USER_SHELL"

EOF

echo "✅ Bootstrap complete! You can now log in as '$USERNAME'."
