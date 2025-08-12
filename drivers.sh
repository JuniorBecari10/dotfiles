#!/bin/bash

# Ensure the script is run with sudo.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with 'sudo'."
  echo "Try again with: 'sudo ./install.sh'."
  exit 1
fi

# Target user (who called sudo)
TARGET_USER=${SUDO_USER:-$USER}
TARGET_HOME=$(eval echo "~$TARGET_USER")

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

echo "Done. Please reboot your computer."
