#!/bin/sh

# List of packages to install
PACKAGES=(
    nvidia
    nvidia-utils
    nvidia-settings
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"

# Rebuild initramfs
mkinitcpio -P
