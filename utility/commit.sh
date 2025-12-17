#!/bin/sh
# Used to commit the configuration files that are on the computer
# to the local repository, so they can be committed to the remote one.
# This is essentially the opposite of 'patch.sh'.
set -e

DOTFILES=~/dotfiles/files
CONFIG="$DOTFILES/.config"

# Make sure the destination exists
mkdir -p "$CONFIG"

# Copy dotfiles from home to dotfiles
cp -f ~/.bashrc "$DOTFILES"
cp -f ~/.sl.sh "$DOTFILES"
cp -f ~/.xinitrc "$DOTFILES"
cp -f ~/.xprofile "$DOTFILES"
cp -f ~/.profile "$DOTFILES"
cp -f ~/.Xresources "$DOTFILES"

# Move contents of ~/.config to dotfiles/.config and
# delete everything the repository doesn't track.
cp -f ~/.config/* "$CONFIG"
git clean -fd "$CONFIG"

# Fix ownership
chown -R "$USER" "$DOTFILES"
