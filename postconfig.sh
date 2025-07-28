#!/bin/sh

# A set of LSPs were written to be used in the 'lspconfig.lua' file, if you one day will use it, just install it.
# There's no need to write it in there.

echo "==> Setting up Neovim's clipboard..."

nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

echo "==> Setting up git..."

git config --global user.name "Antônio Carlos"
git config --global user.email "antonioocarlos@proton.me"

echo "==> Setting up GitHub CLI..."
gh auth login

echo "==> Installing AUR helper 'yay'"

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay
