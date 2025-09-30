#!/usr/bin/sh

# Source configs
source ../configs.sh

HOME="/home/$USERNAME"
CONFIG="$HOME/.config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp -r ../files/.bashrc "$HOME"
cp -r ../files/.sl.sh "$HOME"
cp -r ../files/.xinitrc "$HOME"

chown $USER:$USER ~/.bashrc ~/.sl.sh ~/.xinitrc

mkdir -p "$CONFIG"
chown $USER:$USER "$CONFIG"

# Copy everything inside '.config' to '~/.config'
cp -r ../files/.config/* "$CONFIG/"
chown -R "$USERNAME:$USERNAME" "$CONFIG"
