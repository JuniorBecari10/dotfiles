#!/bin/sh

# Source configs from the copied file
. /general.sh

HOME="/home/$USERNAME"
DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to "$HOME"
# Don't replace existing '.sl.sh' if it already exists.
cp -f "$DOTFILES/files/.bashrc" "$HOME/"
cp -n "$DOTFILES/files/.sl.sh" "$HOME/"
cp -f "$DOTFILES/files/.xinitrc" "$HOME/"

# Fix ownership
chown "$USERNAME:$USERNAME" "$HOME/.bashrc" "$HOME/.sl.sh" "$HOME/.xinitrc"

# Ensure ~/.config exists
mkdir -p "$CONFIG"
chown "$USERNAME:$USERNAME" "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -rf "$DOTFILES/files/.config/"* "$CONFIG/"
chown -R "$USERNAME:$USERNAME" "$CONFIG"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    ./scripts/odb-laptop_config.sh
fi
