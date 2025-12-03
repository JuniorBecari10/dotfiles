#!/bin/sh
set -e

PACKAGES="
nvidia
nvidia-libs
dkms
linux-headers
"

# Update repo index and install packages
xbps-install -Sy $PACKAGES

# Rebuild initramfs
dracut --force
