#!/bin/sh
# Used to commit the configuration files that are on the computer
# to the local repository, so they can be committed to the remote one.
# This is essentially the opposite of 'patch.sh'.
set -e

DOTFILES=~/dotfiles/files
CONFIG="$DOTFILES/.config"

# Force copy contents of ~/.config to files/.config and
# delete everything the repository doesn't track.
# This already cleans untracked files.
cp -rf "$HOME/.config/"* "$CONFIG/"
git clean -fd "$CONFIG"

# TODO: this also copies laptop-patched files

# Fix ownership
chown -R "$USER" "$DOTFILES"
