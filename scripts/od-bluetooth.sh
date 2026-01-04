#!/bin/sh
set -e

# Source configs from the copied file
. /config.sh

HOME="/home/$USERNAME"
"$HOME/dotfiles/scripts/odd-bluetooth.sh"
