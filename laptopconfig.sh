#!/bin/sh

# Ensure the script is run with sudo.
# Do not run this as root, since this will be applied to it, not your user.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with 'sudo'."
  echo "Try again with: 'sudo ./install.sh'."
  exit 1
fi

# Target user (who called sudo)
TARGET_USER=${SUDO_USER:-$USER}
TARGET_HOME=$(eval echo "~$TARGET_USER")
TARGET_CONFIG="$TARGET_HOME/.config"

# List of packages to install
PACKAGES=(
    brightnessctl
    acpi
    python3
)

# Install packages
pacman -Syu --noconfirm "${PACKAGES[@]}"
echo "Done."

# TODO: uncomment laptop-specific blocks from i3blocks configuration file.
