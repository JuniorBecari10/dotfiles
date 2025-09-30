#!/bin/sh

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
    ripgrep
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    adw-gtk-theme
    # lxappearance # disabled, may not be needed
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"

# Refresh font cache
fc-cache -fv

# Enable networkmanager and lightdm services
systemctl enable NetworkManager
systemctl enable lightdm

systemctl set-default graphical.target
