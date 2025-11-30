#!/bin/sh

PACKAGES="
nvidia
nvidia-libs
dkms
linux-headers
dracut
"

# Update repo index and install packages
xbps-install -Sy $PACKAGES

# Rebuild initramfs
dracut --force
