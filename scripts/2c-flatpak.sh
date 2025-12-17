#!/bin/sh
set -e

# List of Flatpak packages to install
FLATPAK_PACKAGES="org.prismlauncher.PrismLauncher"

# Ensure Flathub remote is enabled
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Flatpak packages
for pkg in $FLATPAK_PACKAGES; do
    flatpak install -y --noninteractive flathub "$pkg"
done
