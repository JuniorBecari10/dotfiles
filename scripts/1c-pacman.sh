#!/bin/sh
set -e

# List of packages to install
PACKAGES=(
    i3-wm
    i3blocks
    i3lock
    kitty
    neovim
    rofi rofi-calc
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
    ripgrep
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    adw-gtk-theme
    flatpak
)

# Install pacman packages
pacman -Syu --noconfirm "${PACKAGES[@]}"

# Workaround for volumeicon to work (install a legacy version of gdk-pixbuf2)
# This will be the only package in the system that won't be upgraded.

GDK_VERSION="2.42.12-2"
GDK_PKG="gdk-pixbuf2-${GDK_VERSION}-x86_64.pkg.tar.zst"
GDK_URL="https://archive.archlinux.org/packages/g/gdk-pixbuf2/${GDK_PKG}"

# Download package if not already present
if [ ! -f "$GDK_PKG" ]; then
    curl -LO "$GDK_URL"
fi

# Install the legacy package
pacman -U --noconfirm "$GDK_PKG"

# Prevent future updates from breaking volumeicon
if ! grep -q "^IgnorePkg.*gdk-pixbuf2" /etc/pacman.conf; then
    sed -i '/\[options\]/a IgnorePkg = gdk-pixbuf2' /etc/pacman.conf
fi

# Clean up downloaded package
rm -f "$GDK_PKG"
