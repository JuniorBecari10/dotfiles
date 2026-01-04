#!/bin/sh
set -e

# set USERNAME to USER only if it isn't already defined
# (running from the installation script it's already set, but running post-installation it isn't)
: "${USERNAME:=$USER}"

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
