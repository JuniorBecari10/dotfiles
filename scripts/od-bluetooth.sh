#!/bin/sh
set -e

# Source configs from the copied file
. /config.sh

# This only installs 'blueman' for GUI management of Bluetooth devices.
# If you prefer using 'bluetoothctl', please install it manually.
PACKAGES="
bluez bluez-alsa blueman
libspa-bluetooth
"

# Install packages
xbps-install -Sy $PACKAGES

# Safe guard to create the bluetooth group if it doesn't exist
getent group bluetooth >/dev/null || groupadd bluetooth

# Add user to 'bluetooth' group
usermod -aG bluetooth "$USERNAME"

# Enable the 'bluetoothd' service
ln -snf "/etc/sv/bluetoothd" /var/service/
