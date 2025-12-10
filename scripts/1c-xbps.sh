#!/bin/sh
set -e

# Source configs from the copied file
. /general.sh

HOME="/home/$USERNAME"

# List of packages to install
PACKAGES="
i3 i3blocks i3lock
kitty
neovim
rofi rofi-calc
redshift
git
pavucontrol
network-manager-applet
firefox
flameshot
feh
xfce4-clipman-plugin
NetworkManager
picom
python3
go
github-cli
volumeicon
xorg xorg-server
xinit
yad
lightdm lightdm-gtk-greeter
unzip
nodejs
arandr
xrandr
pipewire wireplumber alsa-pipewire
xclip
Thunar
fastfetch
tree
ripgrep
xorg-fonts
noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji
adwaita-icon-theme adwaita-qt
flatpak
vlc
curl
dracut
dbus elogind
"

# Install packages
xbps-install -Sy $PACKAGES

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
DOTNET_DIR="/usr/share/dotnet"
DOTNET_BIN="/usr/bin/dotnet"

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh

./dotnet-install.sh --channel LTS --install-dir "$DOTNET_DIR"

ln -sf "$DOTNET_DIR/dotnet" "$DOTNET_BIN"
rm dotnet-install.sh
