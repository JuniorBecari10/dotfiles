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
  fsautocomplete
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
  fsharp
  html
  css
)

# Build the MasonInstall command
MASON_LSP_CMD="MasonInstall ${LSPs[*]}"
TREESITTER_CMD="TSInstallSync ${TREESITTERS[*]}"

nvim --headless +"MasonInstallAll" +qa
nvim --headless +"$MASON_LSP_CMD" +qa
nvim --headless +"$TREESITTER_CMD" +qa

echo "Mason and Tree-sitter setup complete."
