#!/bin/sh

# Refresh font cache
fc-cache -fv

# Enable networkmanager and lightdm services
systemctl enable NetworkManager
systemctl enable lightdm

systemctl set-default graphical.target
