#!/bin/sh
set -e

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# Soft link files to "$HOME"
# Don't replace existing '.sl.sh' if it already exists.
ln -sf "$DOTFILES/files/.bashrc" "$HOME/"
ln -sf "$DOTFILES/files/.xinitrc" "$HOME/"
ln -sf "$DOTFILES/files/.xprofile" "$HOME/"
ln -sf "$DOTFILES/files/.Xresources" "$HOME/"
cp -n "$DOTFILES/files/.sl.sh" "$HOME/"

# Ensure ~/.config exists
mkdir -p "$CONFIG"

# Force copy everything inside 'files/.config' to '~/.config'
cp -rf "$DOTFILES/files/.config/"* "$CONFIG/"

# Create convenience folders
mkdir -p "$HOME/dev"
mkdir -p "$HOME/docs"
mkdir -p "$HOME/Downloads" # Because of Firefox

# Give all the files inside ~ ownership to the user
chown -R "$USERNAME" "$HOME"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    "$DOTFILES/scripts/ocbb-laptop_config.sh"
fi
