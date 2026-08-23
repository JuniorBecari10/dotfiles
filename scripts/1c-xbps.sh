#!/bin/sh
set -e

# Source configs from the copied file
. /config.sh

HOME="/home/$USERNAME"

# List of packages to install
PACKAGES="
i3 i3blocks i3lock
kitty xterm
helix yazi
rofi rofi-calc
redshift
git
pavucontrol
network-manager-applet
firefox
maim swappy
feh xtools-minimal
xfce4-clipman-plugin
NetworkManager
xcompmgr rustup
python3 tree
go ripgrep
github-cli 7zip numlockx
xorg-minimal xf86-input-libinput setxkbmap
xinit fontconfig mesa-dri
yad polkit dunst
lightdm lightdm-gtk-greeter
zip unzip
xrandr
arandr
pipewire alsa-pipewire
xclip
Thunar
fastfetch
noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji
flatpak
htop curl
dracut
dbus elogind
wget chrony
"

# Install packages
xbps-install -Syu $PACKAGES

# Font variables
FONT_DIR="/usr/share/fonts/TTF"
CACHE_DIR="$HOME/.cache/fonts"
JETBRAINS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"

mkdir -p "$FONT_DIR"
mkdir -p "$CACHE_DIR"

curl -L "$JETBRAINS_URL" -o "$CACHE_DIR/JetBrainsMono.zip"
unzip -o "$CACHE_DIR/JetBrainsMono.zip" -d "$FONT_DIR"

fc-cache -fv

# Install latest .NET SDK LTS
"$HOME/dotfiles/scripts/1ca-dotnet.sh"
