#!/bin/sh
set -e

PACKAGES="
nvidia-dkms
linux-headers
dkms
"

# Enable the nonfreepackage
xbps-install -Sy void-repo-nonfree

# Update repo index and install packages
xbps-install -Sy $PACKAGES

# Regenerate initramfs
xbps-reconfigure -fa
