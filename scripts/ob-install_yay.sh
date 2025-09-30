#!/bin/sh

# Install AUR helper 'yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay
