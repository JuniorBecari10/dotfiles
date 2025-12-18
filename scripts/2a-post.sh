#!/bin/sh
set -e

# Perform network config as root
sudo ~/dotfiles/scripts/2b-network.sh
~/dotfiles/scripts/2c-flatpak.sh
~/dotfiles/scripts/2d-gtk.sh

# Set up neovim's clipboard (requires 'xclip' installed, if on Xorg)
nvim --headless \
  +"set clipboard+=unnamedplus" \
  +qa

# Set up git configurations
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global core.editor "nvim"
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global push.autoSetupRemote true

# Run Firefox in background, while the command below opens a tab in it
# Meanwhile you can log into your account.
firefox &

# Set up GitHub CLI to link git to your GitHub account
# (requires Firefox to be the default browser - this is set if you run it at least once before this)
gh auth login
