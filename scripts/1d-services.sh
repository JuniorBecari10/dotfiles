#!/bin/sh
set -e

# enable services
for svc in dbus elogind NetworkManager lightdm; do
    ln -snf "/etc/sv/$svc" /var/service/ || true
done
