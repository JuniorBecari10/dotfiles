#!/bin/sh

# Source settings
. ./settings/general.sh

# Install Flatpak apps
./scripts/2b-flatpak.sh

# Create convenience folders
mkdir -p ~/dev
mkdir -p ~/docs
mkdir -p ~/Downloads # Because of Firefox

# Set up neovim's clipboard (requires 'xclip' installed, if on Xorg)
nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

# Set up audio services
if [ -d /etc/sv/pipewire ]; then
    ln -sf /etc/sv/pipewire /var/service/
fi

if [ -d /etc/sv/pipewire-pulse ]; then
    ln -sf /etc/sv/pipewire-pulse /var/service/
fi

if [ -d /etc/sv/wireplumber ]; then
    ln -sf /etc/sv/wireplumber /var/service/
fi

# Start system tray volume icon in background
volumeicon &

# Set up git configurations
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main

# Run Firefox in background, while the command below opens a tab in it
# Meanwhile you can log into your account.
firefox &

# Set up GitHub CLI to link git to your GitHub account
# (requires Firefox to be the default browser - this is set if you run it at least once before this)
gh auth login
