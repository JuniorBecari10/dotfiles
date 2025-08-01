#!/bin/sh

# This must be run after rebooting, when the WM is running.

# A set of LSPs were written to be used in the 'lspconfig.lua' file, if you one day will use it, just install it.
# There's no need to write it in there.

# Set up neovim's clipboard (requires 'xclip' installed, if on Xorg)
nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

# Set up audio services
systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service

# Start system tray volume icon in background
volumeicon &

# Install AUR helper 'yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay

# Set up git configurations
git config --global user.name "Antônio Carlos"
git config --global user.email "antonioocarlos@proton.me"

# Run Firefox in background, while the command below opens a tab in it
firefox &

# Set up GitHub CLI to link git to your GitHub account
# (requires Firefox to be the default browser - this is set if you run it at least once before this)
gh auth login
