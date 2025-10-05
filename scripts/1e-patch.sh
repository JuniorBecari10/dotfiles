#!/bin/sh

# Source configs
. ./settings/general.sh

HOME="/home/$USERNAME"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp -rf ./files/.bashrc "$HOME"
cp -rf ./files/.sl.sh "$HOME"
cp -rf ./files/.xinitrc "$HOME"

chown $USER:$USER ~/.bashrc ~/.sl.sh ~/.xinitrc

mkdir -p "$CONFIG"
chown $USER:$USER "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -rf ./files/.config/* "$CONFIG/"
chown -R "$USERNAME:$USERNAME" "$CONFIG"

# Perform again the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    ./scripts/odb-laptop_config.sh
fi
