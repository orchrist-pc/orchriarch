#!/usr/bin/env bash
# ============================================================= #
#  ██████╗ ██████╗  ██████╗██╗  ██╗██████╗ ██╗███████╗████████╗ #
# ██╔═══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██║██╔════╝╚══██╔══╝ #
# ██║   ██║██████╔╝██║     ███████║██████╔╝██║███████╗   ██║    #
# ██║   ██║██╔══██╗██║     ██╔══██║██╔══██╗██║╚════██║   ██║    #
# ╚██████╔╝██║  ██║╚██████╗██║  ██║██║  ██║██║███████║   ██║    #
#  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝    #
#               █▀▄ █▀█ ▀█▀   █▀▀ ▀█▀ █   █▀▀ █▀▀               #
#               █ █ █ █  █    █▀▀  █  █   █▀▀ ▀▀█               #
#               ▀▀  ▀▀▀  ▀    ▀   ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀               #
# ============================================================= #

set -euo pipefail

# Get repository directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source library functions
source "$REPO_DIR/lib/utils.sh"
source "$REPO_DIR/lib/checks.sh"
source "$REPO_DIR/lib/packages.sh"
source "$REPO_DIR/lib/dotfiles.sh"
source "$REPO_DIR/lib/themes.sh"
source "$REPO_DIR/lib/greeter.sh"

# Installation state variables
INSTALL_HYPRLAND=true
INSTALL_NIRI=false
OPTIONAL_APPS=()

# Display welcome screen
show_welcome() {
    print_banner

    cat << 'EOF'
This installer will set up Beautiful Dots configurations for:
  • Hyprland - Dynamic tiling Wayland compositor
  • Desktop Shell - Choose between Noctalia (recommended) or DMS
  • Catppuccin Mocha theme across all applications

The installer will:
  1. Check your system requirements
  2. Let you choose which compositor(s) to install
  3. Let you choose your preferred desktop shell (Noctalia or DMS)
  4. Install required packages and optional applications
  5. Deploy configuration files (via symlinks)
  6. Apply themes and set up the display manager

Your existing .config will be backed up before any changes.

EOF

    if ! prompt_yes_no "Do you want to continue?" "y"; then
        echo ""
        log_info "Installation cancelled"
        exit 0
    fi
}

# User selection menu for compositors
select_compositors() {
    log_step "Compositor Selection"
    INSTALL_HYPRLAND=true
    echo ""
    log_info "Selected compositors:"
    [ "$INSTALL_HYPRLAND" = true ] && echo "  • Hyprland"
    echo ""
}

# User selection menu for optional apps
select_optional_apps() {
    log_step "Optional Applications"

    echo "Select optional applications to install (enter numbers separated by spaces, or press Enter to skip):"
    echo ""
    echo "1) Zed (modern code editor)"
    echo "2) Helix (modal text editor)"
    echo "3) Obsidian (notes vault)"
    echo "4) Discord"
    echo "5) Macro Tools (wtype + xdotool)"
    echo "6) Docker (docker + docker-compose)"
    echo "7) Flatpak"
    echo ""

    read -p "Enter your choices (e.g. 'a' to install all, '1 2 3 4' for specifics, or just Enter to skip): " choices

    # Parse selections
    for choice in $choices; do
        case $choice in
            a)
             OPTIONAL_APPS+=("zed")
             OPTIONAL_APPS+=("helix")
             OPTIONAL_APPS+=("obsidian")
             OPTIONAL_APPS+=("discord")
             OPTIONAL_APPS+=("wtype")
             OPTIONAL_APPS+=("xdotool")
             OPTIONAL_APPS+=("docker")
             OPTIONAL_APPS+=("docker-compose")
             OPTIONAL_APPS+=("flatpak")
             ;;
            1) OPTIONAL_APPS+=("zed") ;;
            2) OPTIONAL_APPS+=("helix") ;;
            3) OPTIONAL_APPS+=("obsidian") ;;
            4) OPTIONAL_APPS+=("discord") ;;
            5)
             OPTIONAL_APPS+=("wtype")
             OPTIONAL_APPS+=("ydotool")
             ;;
            6)
             OPTIONAL_APPS+=("docker")
             OPTIONAL_APPS+=("docker-compose")
             ;;
            7) OPTIONAL_APPS+=("flatpak") ;;
            *) log_warn "Invalid choice '$choice' ignored" ;;
        esac
    done

    echo ""
    if [ ${#OPTIONAL_APPS[@]} -gt 0 ]; then
        log_info "Selected optional applications:"
        for app in "${OPTIONAL_APPS[@]}"; do
            echo "  • $app"
        done
    else
        log_info "No optional applications selected"
    fi
    echo ""
}

# Backup confirmation
confirm_backup() {
    log_step "Configuration Backup"

    log_info "Your existing ~/.config directory will be backed up before installation"
    echo ""

    if prompt_yes_no "Create backup of existing configurations?" "y"; then
        backup_existing_configs
    else
        log_warn "Skipping backup (not recommended)"
    fi
    echo ""
}

# Post-installation steps
post_install() {
    log_step "Post-Installation"
    # Create screenshots directory
    mkdir -p $HOME/Pictures/Screenshots

    # Offer to set fish as default shell
    if command_exists fish; then
        echo ""
        if prompt_yes_no "Set fish as your default shell?" "y"; then
            sudo chsh -s /usr/bin/fish "$(detect_user)"
            log_success "Default shell set to fish"
        fi
    fi

    echo ""
    print_separator
    echo ""
    log_success "Installation Complete!"
    echo ""
    echo -e "${CYAN}Next Steps:${NC}"
    echo "  1. Reboot your system to activate the display manager"
    echo "  2. At the login screen, select your preferred session:"
    [ "$INSTALL_HYPRLAND" = true ] && echo "     • Hyprland"
    [ "$INSTALL_NIRI" = true ] && echo "     • Niri"
    echo "  3. Log in and enjoy your beautiful desktop!"
    echo ""
    echo -e "${CYAN}Configuration Files:${NC}"
    echo "  All configs are symlinked from: $REPO_DIR/configs/"
    echo "  Edit files in the repo and changes will apply immediately"
    echo ""

    echo -e "${YELLOW}Tip:${NC} Keep the orchriarch directory to easily update configs!"
    echo ""
    print_separator
    echo ""

    if prompt_yes_no "Reboot now?" "n"; then
        log_info "Rebooting..."
        sleep 2
        sudo reboot
    else
        log_info "Remember to reboot before using the new desktop environment"
    fi
}

# Main installation flow
main() {
    # Welcome screen
    show_welcome

    # Run system checks
    run_all_checks || die "System checks failed"

    # User selections
    select_compositors
    select_optional_apps
    #select_dcli

    # Confirm backup
    confirm_backup

    # Install packages
    install_core_packages "$REPO_DIR" || die "Failed to install core packages"
    install_compositor_packages "$REPO_DIR" "$INSTALL_HYPRLAND" || die "Failed to install compositor packages"
    install_theme_packages "$REPO_DIR" || die "Failed to install theme packages"
    install_dms_packages "$REPO_DIR" || die "Failed to install shell packages"
    install_required_apps "$REPO_DIR" || die "Failed to install required applications"

    if [ ${#OPTIONAL_APPS[@]} -gt 0 ]; then
        install_optional_apps "$REPO_DIR" "${OPTIONAL_APPS[@]}"
    fi

    # Deploy configurations
    deploy_configurations "$REPO_DIR" "$INSTALL_HYPRLAND" || die "Failed to deploy configurations"

    # Apply themes
    apply_themes "$REPO_DIR" "$INSTALL_HYPRLAND" || die "Failed to apply themes"

    # Setup greeter
    setup_greeter "$INSTALL_HYPRLAND" || die "Failed to setup greeter"

    # Post-installation
    post_install
}

# Run main installation
main
