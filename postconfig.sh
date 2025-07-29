#!/bin/sh

# A set of LSPs were written to be used in the 'lspconfig.lua' file, if you one day will use it, just install it.
# There's no need to write it in there.

# Set up neovim's clipboard (requires 'xclip' installed, if on Xorg)
nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

# Set up git configurations
git config --global user.name "Antônio Carlos"
git config --global user.email "antonioocarlos@proton.me"

# Set up GitHub CLI to link git to your GitHub account
gh auth login

# Install 'yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay
