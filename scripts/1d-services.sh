#!/bin/sh

# Enable networkmanager and lightdm services
ln -sf /etc/runit/sv/NetworkManager /var/service/
ln -sf /etc/runit/sv/lightdm /var/service/
