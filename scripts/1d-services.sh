#!/bin/sh
set -e

# Ensure /var/service is a real directory (not a broken symlink)
if [ -L /var/service ] && [ ! -e /var/service ]; then
    rm -f /var/service
fi

if [ ! -d /var/service ]; then
    # Replace with real directory
    rm -f /var/service 2>/dev/null || true
    mkdir -p /var/service
fi

# Enable services
for svc in dbus elogind NetworkManager lightdm; do
    if [ -d "/etc/sv/$svc" ]; then
        ln -snf "/etc/sv/$svc" /var/service/
    else
        echo "Warning: service '$svc' does not exist in /etc/sv/"
    fi
done
