# Dotfiles

> I use Arch btw with Hyprland 🚀

## Quick Start

```bash
# Clone the repo
git clone https://github.com/meetthehorizon/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install packages
./pkg-manager.sh install

# Stow config directories
stow fish hypr waybar wezterm rofi fastfetch wlogout desktop
```

## Structure

| Directory    | Description                                     |
| ------------ | ----------------------------------------------- |
| `fish/`      | Fish shell + Starship prompt config             |
| `hypr/`      | Hyprland, hyprlock, hypridle, hyprpaper configs |
| `waybar/`    | Waybar status bar                               |
| `wezterm/`   | WezTerm terminal                                |
| `rofi/`      | Rofi launcher theme                             |
| `fastfetch/` | System info display                             |
| `wlogout/`   | Logout menu                                     |
| `desktop/`   | Custom .desktop files                           |
| `system/`    | Package lists & services for reproducibility    |

## Package Management

The `pkg-manager.sh` script manages system reproducibility:

```bash
./pkg-manager.sh generate   # Regenerate lists from current system
./pkg-manager.sh install    # Install packages from lists
./pkg-manager.sh services   # Enable systemd services
./pkg-manager.sh all        # Install + enable services
```

**Package lists** (in `system/`):

- `pkglist-pacman.txt` - Official repo packages
- `pkglist-aur.txt` - AUR packages
- `services-enabled.txt` - Enabled systemd services

## Notes

- See the **Nvidia** section of [Hyprland Wiki](https://wiki.hyprland.org/Nvidia/) and configure `hyprland.conf` accordingly
- Uses **stow** for symlink management

---

_Fork this repo and enjoy!_
