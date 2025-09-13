#!/usr/bin/sh
# No need to run this as sudo, but run it with your user.

CONFIG=".config"

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp files/.bashrc ~
cp files/.sl.sh ~
cp files/.xinitrc ~

chown $USER:$USER ~/.bashrc ~/.sl.sh ~/.xinitrc

mkdir -p "$CONFIG"
chown $USER:$USER "$CONFIG"

# Copy everything inside '.config' to '~/.config'
if [ -d ".config" ]; then
    cp -r .config/* "$CONFIG/"
    chown -R "$USER:$USER" "$CONFIG"
else
    echo "ERROR: No '.config' directory found in dotfiles!"
fi
