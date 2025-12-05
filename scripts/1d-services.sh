#!/bin/sh
set -e

# Fix broken symlink for runit the installer generates
rm -rf /var/service
ln -s /etc/runit/runsvdir/current /var/service

# Fix broken symlink for DNS
ln -sf /run/NetworkManager/resolv.conf /etc/resolv.conf

# Enable services
for svc in dbus elogind NetworkManager lightdm; do
    ln -snf "/etc/sv/$svc" /var/service/
done
