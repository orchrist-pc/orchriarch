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

# Source utils for logging
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

# Create symlink (removing existing files/symlinks first)
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    local target_dir=$(dirname "$target")
    mkdir -p "$target_dir"

    # Remove existing file/symlink if present
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    # Create symlink
    ln -sf "$source" "$target"
}

# Deploy assets directory
deploy_assets() {
    local repo_dir="$1"
    local user_home=$(get_user_home)
    local config_dir="$user_home/.config"

    log_info "Deploying assets..."

    if [ -d "$repo_dir/assets" ]; then
        create_symlink "$repo_dir/assets" "$config_dir/orchriarch/assets"
        log_success "Assets linked to $config_dir/orchriarch/assets"
    fi
}

# Deploy shared configurations
deploy_shared_configs() {
    local repo_dir="$1"
    local user_home=$(get_user_home)
    local config_dir="$user_home/.config"

    log_info "Deploying shared configurations..."

    local shared_configs=(
        "kitty"
        "fish"
        "gtk-3.0"
        "gtk-4.0"
    )

    for config in "${shared_configs[@]}"; do
        if [ -d "$repo_dir/configs/shared/$config" ]; then
            log_info "Linking $config..."
            create_symlink "$repo_dir/configs/shared/$config" "$config_dir/$config"
        fi
    done

    # Handle Qt configs separately to process $HOME variable
    for qt_config in "qt5ct" "qt6ct"; do
        if [ -d "$repo_dir/configs/shared/$qt_config" ]; then
            log_info "Processing $qt_config config with path expansion..."
            mkdir -p "$config_dir/$qt_config"
            if [ -f "$repo_dir/configs/shared/$qt_config/${qt_config}.conf" ]; then
                sed "s|\$HOME|$user_home|g" "$repo_dir/configs/shared/$qt_config/${qt_config}.conf" > "$config_dir/$qt_config/${qt_config}.conf"
            fi
            # Copy other files if they exist
            find "$repo_dir/configs/shared/$qt_config" -type f ! -name "${qt_config}.conf" -exec cp {} "$config_dir/$qt_config/" \; 2>/dev/null || true
        fi
    done

    # Handle fastfetch separately to process $HOME variable
    if [ -d "$repo_dir/configs/shared/fastfetch" ]; then
        log_info "Processing fastfetch config with path expansion..."
        mkdir -p "$config_dir/fastfetch"
        if [ -f "$repo_dir/configs/shared/fastfetch/config.jsonc" ]; then
            sed "s|\$HOME|$user_home|g" "$repo_dir/configs/shared/fastfetch/config.jsonc" > "$config_dir/fastfetch/config.jsonc"
        fi
        # Copy other fastfetch files if they exist
        find "$repo_dir/configs/shared/fastfetch" -type f ! -name "config.jsonc" -exec cp {} "$config_dir/fastfetch/" \; 2>/dev/null || true
    fi

    log_success "Shared configurations deployed"
}

# Deploy Hyprland configurations
deploy_hyprland_configs() {
    local repo_dir="$1"
    local user_home=$(get_user_home)
    local config_dir="$user_home/.config"

    log_info "Deploying Hyprland configurations..."

    # Link hypr directory
    if [ -d "$repo_dir/configs/hyprland/hypr" ]; then
        log_info "Linking Hyprland configs..."
        create_symlink "$repo_dir/configs/hyprland/hypr" "$config_dir/hypr"
    fi

    # Link zed directory
    if [ -d "$repo_dir/configs/hyprland/zed" ]; then
        log_info "Linking Zed editor configs..."
        create_symlink "$repo_dir/configs/hyprland/zed" "$config_dir/zed"
    fi

    log_success "Hyprland configurations deployed"
}


# Merge DMS settings (base + compositor-specific)
merge_dms_configs() {
    local repo_dir="$1"
    local compositor="$2"  # "hyprland" or "niri"
    local user_home=$(get_user_home)
    local config_dir="$user_home/.config"
    local dms_dir="$config_dir/DankMaterialShell"

    log_warn "Creating Symlink for DMS"
    create_symlink "$repo_dir/configs/$compositor/DankMaterialShell" "$dms_dir"

    log_info "Replacing hardcoded paths in DMS Settings"
    sed -i -r "s|/home/orchrist|$user_home|g" "$repo_dir/configs/hyprland/DankMaterialShell/settings.json"
    
    log_success "DMS configurations merged"
}

# Main deployment function
deploy_configurations() {
    local repo_dir="$1"
    local install_hyprland="$2"
    local user_home=$(get_user_home)

    log_step "Deploying Configurations"

    # Deploy assets first
    deploy_assets "$repo_dir"

    # Always deploy shared configs
    deploy_shared_configs "$repo_dir"

    # Deploy compositor-specific configs
    if [ "$install_hyprland" = "true" ]; then
        deploy_hyprland_configs "$repo_dir"
        merge_dms_configs "$repo_dir" "hyprland"
    fi

    rm -rf "$repo_dir/configs/shared/gtk-3.0/bookmarks"

    log_info "Setting default monitor and workspaces configurations..."
    sed -i -r "s|/monitors/.*\.conf|/monitors/default.conf|1" "$repo_dir/configs/hyprland/hypr/hyprland.conf"
    sed -i -r "s|/workspaces/.*\.conf|/workspaces/default.conf|1" "$repo_dir/configs/hyprland/hypr/hyprland.conf"
    sed -i -r "s|/home/orchrist|$user_home|1" "$repo_dir/configs/hyprland/hypr/scripts/monitorconfigs.sh"

    log_info "Commenting out including custom config files for hyprland and fish..."
    sed -i -r 's|/mnt/Storage/Config\ Files/dotfiles/|~/.config/hypr/config/|1' "$repo_dir/configs/hyprland/hypr/hyprland.conf"
    sed -i -r 's|"/mnt/Storage/Config Files/dotfiles/custom.fish"|~/.config/fish/custom.fish|1' "$repo_dir/configs/shared/fish/config.fish"

    log_success "All configurations deployed successfully"
}
