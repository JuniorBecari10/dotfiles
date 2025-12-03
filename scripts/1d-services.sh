#!/bin/sh
set -e

# Enable dbus and elogind
ln -sf /etc/sv/dbus /var/service/
ln -sf /etc/sv/elogind /var/service/

# Enable networking and display manager
ln -sf /etc/sv/NetworkManager /var/service/
ln -sf /etc/sv/lightdm /var/service/
