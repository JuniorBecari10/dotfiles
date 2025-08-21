#!/bin/sh

# Ensure the script is run with sudo
# Do not run this as root, since this will be applied to it, not your user.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with 'sudo'."
  echo "Try again with: 'sudo ./install.sh'."
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
    xorg xorg-server
    xorg-xinit
    yad
    lightdm
    lightdm-gtk-greeter
    lightdm-gtk-greeter-settings
    unzip
    npm
    arandr
    xorg-xrandr
    pipewire pipewire-audio pipewire-pulse pipewire-alsa wireplumber
    xclip
    dotnet-sdk dotnet-runtime
    thunar
    reflector
    fastfetch
    tree
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"

# Enable networkmanager and lightdm services
systemctl enable NetworkManager
systemctl enable lightdm

systemctl set-default graphical.target

# Copy '.bashrc', '.sl.sh' and '.xinitrc' to '~'
cp .bashrc "$TARGET_HOME/"
cp .sl.sh "$TARGET_HOME/"
cp .xinitrc "$TARGET_HOME/"

chown $TARGET_USER:$TARGET_USER "$TARGET_HOME/.bashrc" "$TARGET_HOME/.sl.sh" "$TARGET_HOME/.xinitrc"

mkdir -p "$TARGET_CONFIG"
chown $TARGET_USER:$TARGET_USER "$TARGET_CONFIG"

# Copy everything inside '.config' to '~/.config'
if [ -d ".config" ]; then
    cp -r .config/* "$TARGET_CONFIG/"
    chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_CONFIG"
else
    echo "ERROR: No '.config' directory found in dotfiles!"
fi

echo "Done."
