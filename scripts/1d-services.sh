#!/bin/sh

# Enable networkmanager and lightdm services
ln -s /etc/runit/sv/NetworkManager /var/service/
ln -s /etc/runit/sv/lightdm /var/service/
