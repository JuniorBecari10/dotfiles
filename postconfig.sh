#!/bin/sh

# Ensure the script is run as the user, not root
if [[ $EUID -eq 0 ]]; then
  echo "Please run this script as your regular user, NOT with sudo."
  echo " Just run: ./postconfigs.sh"
  exit 1
fi

echo "==> Running post-setup configuration with Neovim..."

# Define LSPs and Tree-sitter parsers you want to install
LSPs=(
  bashls
  pyright
  clangd
  tsserver
  lua_ls
  gopls
  html
  cssls
)

TREESITTERS=(
  bash
  lua
  go
  python
  javascript
  typescript
  c
  cpp
  html
  css
)

# Build the MasonInstall command
LSP_LIST="${LSPs[*]}"
TS_LIST="${TREESITTERS[*]}"

nvim --headless +"lua require('lazy').setup()" \
  +"MasonInstall $LSP_LIST" \
  +"TSInstall $TS_LIST" \
  +qa

echo "Mason and Tree-sitter setup complete."
