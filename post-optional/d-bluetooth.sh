#!/bin/sh
set -e

sudo ~/dotfiles/scripts/odd-bluetooth.sh
echo "Done. Reboot your system or restart 'dbus', then logout of your session and log back in to apply the Bluetooth configurations."
echo "Just restarting is easier, btw."
