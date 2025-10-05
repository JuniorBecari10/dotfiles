#!/bin/sh

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
    # lxappearance # disabled, may not be needed
    # mpg123 # maybe pavucontrol needs it
)

# Install pacman packages
pacman -Syu --noconfirm "${PACKAGES[@]}"
