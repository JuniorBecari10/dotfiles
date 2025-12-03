#!/bin/sh
set -e

# Fix broken symlink the installer generates
rm -rf /var/service
ln -s /run/runit/runsvdir/current /var/service

# Enable services
for svc in dbus elogind NetworkManager lightdm; do
    ln -snf "/etc/sv/$svc" /var/service/
done
