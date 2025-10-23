#!/bin/sh

# Source configs
. ./settings/general.sh

HOME="/home/$USERNAME"
CONFIG="$HOME/.config"

# Symlink '.bashrc', '.sl.sh' and '.xinitrc' to '~'
ln -sf ./files/.bashrc "$HOME"
ln -sf ./files/.sl.sh "$HOME"
ln -sf ./files/.xinitrc "$HOME"

# Ensure ~/.config exists
mkdir -p "$CONFIG"

# Recursively symlink .config contents
cd "$DOTFILES/.config" || exit 1
find . -type d -exec mkdir -p "$CONFIG/{}" \;

find . -type f | while read -r file; do
    target="$CONFIG/$file"
    src="$DOTFILES/.config/$file"
    
    ln -sf "$src" "$target"
done

# Perform laptop-specific changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    ./scripts/odb-laptop_config.sh
fi
