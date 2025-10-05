#!/bin/sh

# List of packages to install
PACKAGES=(
    brightnessctl
    acpi
    python3
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"
