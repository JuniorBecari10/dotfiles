#!/bin/sh

# Source configs
. ./settings/general.sh

HOME="/home/$USERNAME"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp ./files/.bashrc "$HOME"
cp -n ./files/.sl.sh "$HOME"
cp ./files/.xinitrc "$HOME"

chown $USER:$USER ~/.bashrc ~/.sl.sh ~/.xinitrc

mkdir -p "$CONFIG"
chown $USER:$USER "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -r ./files/.config/* "$CONFIG/"
chown -R "$USERNAME:$USERNAME" "$CONFIG"
