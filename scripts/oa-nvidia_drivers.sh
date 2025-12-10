#!/bin/sh
set -e

PACKAGES="
nvidia
nvidia-dkms
linux6.12-headers
dkms
"

# Enable the nonfree package
xbps-install -Sy void-repo-nonfree

# Update repo index and install packages
xbps-install -Sy $PACKAGES

# Fix issue with nouveau
echo "blacklist nouveau options nouveau modeset=0" > /etc/modprobe.d/blacklist-nouveau.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia-drm.conf

# Regenerate initramfs
xbps-reconfigure -fa
