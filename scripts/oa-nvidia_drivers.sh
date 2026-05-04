#!/bin/sh
set -e

PACKAGES="
nvidia580
dkms
"

# Enable the nonfree package
xbps-install -Sy void-repo-nonfree

# Install packages
xbps-install -Sy $PACKAGES
