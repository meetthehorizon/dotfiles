#!/bin/bash
# Package and service list manager for dotfiles reproducibility

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACMAN_LIST="$DOTFILES_DIR/pkglist-pacman.txt"
AUR_LIST="$DOTFILES_DIR/pkglist-aur.txt"
SERVICES_LIST="$DOTFILES_DIR/services-enabled.txt"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

generate_lists() {
    print_header "Generating package and service lists"
    
    echo -e "${YELLOW}→ Generating pacman package list...${NC}"
    {
        echo "# Pacman explicitly installed packages (native)"
        echo "# Reinstall with: sudo pacman -S --needed - < pkglist-pacman.txt"
        pacman -Qqen | sort
    } > "$PACMAN_LIST"
    echo -e "${GREEN}  ✓ Saved to pkglist-pacman.txt ($(grep -c '^[^#]' "$PACMAN_LIST") packages)${NC}"
    
    echo -e "${YELLOW}→ Generating AUR package list...${NC}"
    {
        echo "# AUR packages (installed via paru)"
        echo "# Reinstall with: paru -S --needed - < pkglist-aur.txt"
        pacman -Qqem | sort
    } > "$AUR_LIST"
    echo -e "${GREEN}  ✓ Saved to pkglist-aur.txt ($(grep -c '^[^#]' "$AUR_LIST") packages)${NC}"
    
    echo -e "${YELLOW}→ Generating enabled services list...${NC}"
    {
        echo "# Enabled systemd services for reproducibility"
        echo "# Enable with: sudo systemctl enable <service>"
        echo ""
        echo "## System Services"
        systemctl list-unit-files --state=enabled --no-pager 2>/dev/null | grep enabled | awk '{print $1}' | grep -v '^$' | sort
        echo ""
        echo "## User Services (enable with: systemctl --user enable <service>)"
        systemctl --user list-unit-files --state=enabled --no-pager 2>/dev/null | grep enabled | awk '{print $1}' | grep -v '^$' | sort
    } > "$SERVICES_LIST"
    echo -e "${GREEN}  ✓ Saved to services-enabled.txt${NC}"
    
    echo -e "\n${GREEN}✓ All lists generated successfully!${NC}"
}

install_packages() {
    print_header "Installing packages from lists"
    
    if [[ ! -f "$PACMAN_LIST" ]] || [[ ! -f "$AUR_LIST" ]]; then
        echo -e "${RED}✗ Package lists not found. Run with 'generate' first.${NC}"
        exit 1
    fi
    
    echo -e "${YELLOW}→ Installing pacman packages...${NC}"
    grep -v '^#' "$PACMAN_LIST" | grep -v '^$' | sudo pacman -S --needed -
    echo -e "${GREEN}  ✓ Pacman packages installed${NC}"
    
    echo -e "${YELLOW}→ Installing AUR packages...${NC}"
    grep -v '^#' "$AUR_LIST" | grep -v '^$' | paru -S --needed -
    echo -e "${GREEN}  ✓ AUR packages installed${NC}"
    
    echo -e "\n${GREEN}✓ All packages installed successfully!${NC}"
}

enable_services() {
    print_header "Enabling systemd services"
    
    if [[ ! -f "$SERVICES_LIST" ]]; then
        echo -e "${RED}✗ Services list not found. Run with 'generate' first.${NC}"
        exit 1
    fi
    
    echo -e "${YELLOW}→ Enabling system services...${NC}"
    in_user_section=false
    while IFS= read -r line; do
        [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
        [[ "$line" == "## User Services"* ]] && in_user_section=true && continue
        [[ "$line" == "## System Services"* ]] && in_user_section=false && continue
        
        if $in_user_section; then
            echo "  Enabling (user): $line"
            systemctl --user enable "$line" 2>/dev/null || true
        else
            echo "  Enabling (system): $line"
            sudo systemctl enable "$line" 2>/dev/null || true
        fi
    done < "$SERVICES_LIST"
    
    echo -e "${GREEN}✓ Services enabled${NC}"
}

show_help() {
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  generate    Regenerate package and service lists from current system"
    echo "  install     Install packages from saved lists"
    echo "  services    Enable services from saved list"
    echo "  all         Install packages and enable services"
    echo "  help        Show this help message"
}

case "${1:-help}" in
    generate|gen|g)
        generate_lists
        ;;
    install|i)
        install_packages
        ;;
    services|svc|s)
        enable_services
        ;;
    all|a)
        install_packages
        enable_services
        ;;
    help|h|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        show_help
        exit 1
        ;;
esac
