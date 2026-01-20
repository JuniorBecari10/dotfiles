#!/bin/sh
# Watch out when running this on laptops, since the commented lines will be sent to the repo uncommented.
# If so, please write '##' before them.
set -e

cp ~/.config/i3/config ~/dotfiles/files/.config/i3/config
cp ~/.config/i3blocks/i3blocks.conf ~/dotfiles/files/.config/i3blocks/i3blocks.conf
