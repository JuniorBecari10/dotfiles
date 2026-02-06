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
rofi rofi-calc rofi-emoji
redshift
git
pavucontrol
network-manager-applet
firefox
flameshot
feh
xfce4-clipman-plugin
NetworkManager
xcompmgr
python3
go ripgrep lazygit
github-cli
volumeicon
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
gtk+3
flatpak
htop
curl
dracut
dbus elogind
PrismLauncher
openjdk11-jre
openjdk8-jre
wget
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
DOTNET_DIR="/usr/share/dotnet"
DOTNET_BIN="/usr/bin/dotnet"

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh

./dotnet-install.sh --channel LTS --install-dir "$DOTNET_DIR"

ln -sf "$DOTNET_DIR/dotnet" "$DOTNET_BIN"
rm dotnet-install.sh

# Install Bun
curl -fsSL https://bun.sh/install | bash
