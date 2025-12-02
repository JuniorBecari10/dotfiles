#!/bin/sh
set -e

# Enable dbus and elogind
ln -sf /etc/runit/sv/dbus /var/service/
ln -sf /etc/runit/sv/elogind /var/service/

# Enable networking and display manager
ln -sf /etc/runit/sv/NetworkManager /var/service/
ln -sf /etc/runit/sv/lightdm /var/service/
