#!/bin/sh

# Source configs
. ./config/general.sh

HOME="/home/$USERNAME"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp -f ./files/.bashrc "$HOME"
cp -n ./files/.sl.sh "$HOME"
cp -f ./files/.xinitrc "$HOME"

chown $USER:$USER ~/.bashrc ~/.sl.sh ~/.xinitrc

mkdir -p "$CONFIG"
chown $USER:$USER "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -rf ./files/.config/* "$CONFIG/"
chown -R "$USERNAME:$USERNAME" "$CONFIG"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    ./scripts/odb-laptop_config.sh
fi
