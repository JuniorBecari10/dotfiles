#!/bin/sh

# Source settings
. ../settings/general.sh

# Set up neovim's clipboard (requires 'xclip' installed, if on Xorg)
nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

# Set up audio services
systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service

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
