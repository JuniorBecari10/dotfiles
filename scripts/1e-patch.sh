#!/bin/sh

# Source configs from the copied file
. /general.sh

HOME="/home/$USERNAME"
DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to "$HOME"
cp -f ./files/.bashrc "$HOME/"
cp -n ./files/.sl.sh "$HOME/"
cp -f ./files/.xinitrc "$HOME/"

# Fix ownership
chown "$USERNAME":"$USERNAME" "$HOME/.bashrc" "$HOME/.sl.sh" "$HOME/.xinitrc"

# Ensure ~/.config exists
mkdir -p "$CONFIG"
chown "$USERNAME":"$USERNAME" "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -rf ./files/.config/* "$CONFIG/"
chown -R "$USERNAME":"$USERNAME" "$CONFIG"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    ./scripts/odb-laptop_config.sh
fi
