#!/bin/sh
# Used separately to patch the dotfiles config files into the system.
set -e

USERNAME="$USER"
~/dotfiles/scripts/1ff-patch.sh
