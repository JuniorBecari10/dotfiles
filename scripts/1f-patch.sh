#!/bin/sh
set -e

# Source configs from the copied file
. /config.sh

HOME="/home/$USERNAME"
DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# Copy config files to "$HOME"
# Don't replace existing '.sl.sh' if it already exists.
cp -f "$DOTFILES/files/.bashrc" "$HOME/"
cp -n "$DOTFILES/files/.sl.sh" "$HOME/"
cp -f "$DOTFILES/files/.xinitrc" "$HOME/"
cp -f "$DOTFILES/files/.xprofile" "$HOME/"
cp -f "$DOTFILES/files/.Xresources" "$HOME/"

# Ensure ~/.config exists
mkdir -p "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -rf "$DOTFILES/files/.config/"* "$CONFIG/"

# Create convenience folders
mkdir -p "$HOME/dev"
mkdir -p "$HOME/docs"
mkdir -p "$HOME/Downloads" # Because of Firefox

# Give all the files inside ~ ownership to the user
chown -R "$USERNAME" "$HOME"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    "$DOTFILES/scripts/odb-laptop_config.sh"
fi
