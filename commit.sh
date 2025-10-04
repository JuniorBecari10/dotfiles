#!/bin/sh
# Used to commit the configuration files that are on the computer to the local repository, so they can be committed to the remote one.
# This is essentially the opposite of 'patch.sh'.

# Source configs
. ./settings/general.sh

HOME="/home/$USERNAME"
DOTFILES="$HOME/dotfiles/files"
CONFIG="$DOTFILES/.config"

# Make sure the destination exists
mkdir -p "$CONFIG"

# Copy dotfiles from home to dotfiles
cp -f "$HOME/.bashrc" "$DOTFILES/"
cp -f "$HOME/.sl.sh" "$DOTFILES/"
cp -f "$HOME/.xinitrc" "$DOTFILES/"

# Move contents of ~/.config to dotfiles/.config
cp -f "$HOME/.config/"* "$CONFIG/"

# Fix ownership
chown -R "$USERNAME:$USERNAME" "$DOTFILES"
