#!/bin/bash

# Ensure the script is run with sudo/root
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run with 'sudo' or as root."
  echo "➡️  Try again with: 'sudo ./install.sh'"
  exit 1
fi

# Target user (who called sudo)
TARGET_USER=${SUDO_USER:-$USER}
TARGET_HOME=$(eval echo "~$TARGET_USER")
TARGET_CONFIG="$TARGET_HOME/.config"

# List of packages to install
PACKAGES=(
    i3-wm
    i3blocks
    kitty
    neovim
    rofi
    redshift
    git
    pavucontrol
    network-manager-applet
    firefox
    ttf-jetbrains-mono-nerd
    flameshot
    feh
    xfce4-clipman-plugin
    networkmanager
    picom
    python3
    go
    github-cli
    volumeicon
    base-devel
    xorg xorg-server
    xorg-xinit
    lightdm
    lightdm-gtk-greeter
    lightdm-gtk-greeter-settings
)

echo "==> Installing packages..."
pacman -Syu --noconfirm "${PACKAGES[@]}"

echo "==> Enabling services..."
systemctl enable NetworkManager
systemctl enable lightdm
systemctl set-default graphical.target

echo "==> Copying '.bashrc' and '.xinitrc' to $TARGET_HOME..."
cp .bashrc "$TARGET_HOME/"
cp .xinitrc "$TARGET_HOME/"
chown $TARGET_USER:$TARGET_USER "$TARGET_HOME/.bashrc" "$TARGET_HOME/.xinitrc"

echo "==> Ensuring $TARGET_CONFIG exists..."
mkdir -p "$TARGET_CONFIG"
chown $TARGET_USER:$TARGET_USER "$TARGET_CONFIG"

# Copy all folders inside .config to ~/.config
if [ -d ".config" ]; then
    echo "==> Copying config directories to '$TARGET_CONFIG/'..."
    for dir in .config/*; do
        if [ -d "$dir" ]; then
            base=$(basename "$dir")
            echo "  -> $base"
            cp -r "$dir" "$TARGET_CONFIG/"
            chown -R $TARGET_USER:$TARGET_USER "$TARGET_CONFIG/$base"
        fi
    done
else
    echo "No '.config' directory found in dotfiles!"
fi

echo "Done."
echo "It is recommended to reboot now."
echo "After reboot, run 'postconfigs.sh' if you have more setup steps."
