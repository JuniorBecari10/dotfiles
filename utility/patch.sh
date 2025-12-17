#!/bin/sh
# Used separately to patch the dotfiles config files into the system.
set -e

HOME="/home/$USERNAME"
SCRIPTS="$HOME/dotfiles/scripts"

"$SCRIPTS/1e-patch.sh"
