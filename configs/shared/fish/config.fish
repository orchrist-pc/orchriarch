if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set cursor theme for niri compositor
set -gx XCURSOR_THEME "Bibata-Modern-Ice"
set -gx XCURSOR_SIZE "24"

# Add scripts directory to PATH
fish_add_path $HOME/.config/scripts

# Add Flutter to PATH
fish_add_path $HOME/Dev/flutter/bin

# Set Chrome executable for Flutter web development
set -gx CHROME_EXECUTABLE /usr/bin/google-chrome-stable

# Helix editor alias
alias hx helix
alias i "yay -S --needed $argv[1]"
alias s "yay $argv[1]"
alias home "z $HOME"
alias murder "ps -aux | grep $argv[1] | awk '{print $2}' | xargs kill -9 $2"
alias die "ps -aux | grep $argv[1] | awk '{print $2}' | xargs kill -9 $2"

zoxide init fish | source

# Configure sudo askpass helper
set -gx SUDO_ASKPASS $HOME/.askpass.sh

source "/mnt/Storage/Config Files/dotfiles/custom.fish"
