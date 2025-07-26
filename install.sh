#!/bin/sh

# Ensure the script is run with sudo/root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with 'sudo' or as root."
  echo " -> Try again with: 'sudo ./install.sh'."

  exit 1
fi

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
    network-manager
    picom
    python3
    neovim
    go
    github-cli
    volumeicon
    pavucontrol
    git
    base-devel
    xorg xorg-xinit
    lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
)

echo "==> Installing packages..."
sudo pacman -Syu --noconfirm "${PACKAGES[@]}"

echo "==> Copying '.bashrc' and '.xinitrc' to '~'..."
cp .bashrc ~/
cp .xinitrc ~/

echo "==> Ensuring ~/.config exists..."
mkdir -p ~/.config

# Copy all folders to '~/.config/'
if [ -d ".config" ]; then
    echo "==> Copying config directories to '~/.config/'..."
    for dir in .config/*; do
        if [ -d "$dir" ]; then
            base=$(basename "$dir")
            echo "  -> $base"
            
            cp -r "$dir" ~/.config/
        fi
    done
else
    echo "No '.config' directory found in dotfiles!"
fi

echo "Done. It is recommended to reboot after this installation."
echo "Then, run 'postconfigs.sh'."
