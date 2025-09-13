#!/bin/sh
# Must be run with sudo.

# List of packages to install
PACKAGES=(
    brightnessctl
    acpi
    python3
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"
echo "Done."

# Uncomment laptop-specific blocks in i3blocks
sed -i 's|##||g' ~/.config/i3blocks/i3blocks.conf
