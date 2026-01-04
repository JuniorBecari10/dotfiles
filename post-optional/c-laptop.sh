#!/bin/sh
set -e

sudo ~/dotfiles/scripts/oca-laptop_install.sh
~/dotfiles/scripts/ocbb-laptop_config.sh
echo "Done. Logout of your session and log back in to apply the laptop configurations."