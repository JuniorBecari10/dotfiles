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

# Move dotfiles from home to dotfiles
mv "$HOME/.bashrc" "$DOTFILES/"
mv "$HOME/.sl.sh" "$DOTFILES/"
mv "$HOME/.xinitrc" "$DOTFILES/"

# Move contents of ~/.config to dotfiles/.config
mv "$HOME/.config/"* "$CONFIG/"

# Fix ownership
chown -R "$USERNAME:$USERNAME" "$DOTFILES"
