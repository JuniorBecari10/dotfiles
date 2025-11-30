#!/bin/sh
set -e

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
lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
unzip
nodejs
arandr
xrandr
pipewire wireplumber
xclip
Thunar
fastfetch
tree
ripgrep
xorg-fonts
noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji
adwaita-icon-theme adwaita-qt
flatpak
"

# Update repo index and install packages
xbps-install -Sy $PACKAGES

# Install JetBrains Mono nerd font
FONT_DIR="/usr/share/fonts/TTF"
JETBRAINS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"

mkdir -p "$FONT_DIR"
mkdir -p ~/.cache/fonts

curl -L "$JETBRAINS_URL" -o ~/.cache/fonts/JetBrainsMono.zip
unzip -o ~/.cache/fonts/JetBrainsMono.zip -d "$FONT_DIR"

fc-cache -fv

# Install latest .NET SDK LTS
curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh

./dotnet-install.sh --channel LTS --install-dir /usr/share/dotnet

ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
rm dotnet-install.sh