#!/bin/sh
set -e

# Source configs from the copied file
. /config.sh

HOME="/home/$USERNAME"
"$HOME/dotfiles/scripts/1ff-patch.sh"
