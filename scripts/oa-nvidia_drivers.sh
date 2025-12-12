#!/bin/sh
set -e

PACKAGES="
nvidia
dkms
"

# Enable the nonfree package
xbps-install -Sy void-repo-nonfree

# Install packages
xbps-install -Sy $PACKAGES

# Fix issue with nouveau. Let's test it without this
# echo "blacklist nouveau options nouveau modeset=0" > /etc/modprobe.d/blacklist-nouveau.conf
# echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia-drm.conf

# (Re)generate initramfs
xbps-reconfigure -fa
