#!/bin/sh

# List of packages to install
PACKAGES=(
    brightnessctl
    acpi
    python3
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"

# Uncomment laptop-specific blocks in i3blocks
sed -i 's|##||g' ~/.config/i3blocks/i3blocks.conf
sed -i 's|##||g' ~/.config/i3/config
