#!/bin/sh
set -e

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# Soft link files to "$HOME"
# Don't replace existing '.sl.sh' if it already exists.
ln -sf "$DOTFILES/files/.bashrc" "$HOME/"
ln -sf "$DOTFILES/files/.xinitrc" "$HOME/"
ln -sf "$DOTFILES/files/.xprofile" "$HOME/"
ln -sf "$DOTFILES/files/.Xresources" "$HOME/"
cp -n "$DOTFILES/files/.sl.sh" "$HOME/" || true

# Ensure ~/.config exists
mkdir -p "$CONFIG"
SRC_CONFIG="$DOTFILES/files/.config"

# First: symlink top-level entries
for item in "$SRC_CONFIG"/*; do
    name="$(basename "$item")"
    dest="$CONFIG/$name"

    case "$name" in
        i3|i3blocks)
            # handled specially below
            ;;
        *)
            [ -e "$dest" ] && rm -rf "$dest"
            ln -sf "$item" "$dest"
            ;;
    esac
done

# Create real directories for exceptions
mkdir -p "$CONFIG/i3" "$CONFIG/i3blocks"

# Copy the excluded config files
cp -f "$SRC_CONFIG/i3/config" "$CONFIG/i3/config"
cp -f "$SRC_CONFIG/i3blocks/i3blocks.conf" "$CONFIG/i3blocks/i3blocks.conf"

# Symlink direct children of i3 (non-recursive)
for item in "$SRC_CONFIG/i3"/*; do
    name="$(basename "$item")"
    [ "$name" = "config" ] && continue
    ln -sfn "$item" "$CONFIG/i3/$name"
done

# Symlink direct children of i3blocks (non-recursive)
for item in "$SRC_CONFIG/i3blocks"/*; do
    name="$(basename "$item")"
    [ "$name" = "i3blocks.conf" ] && continue
    ln -sfn "$item" "$CONFIG/i3blocks/$name"
done

# Create convenience folders
mkdir -p "$HOME/dev"
mkdir -p "$HOME/docs"
mkdir -p "$HOME/programs"
mkdir -p "$HOME/Downloads" # Because of Firefox

# Give all the files inside ~ ownership to the user
chown -R "$USERNAME" "$HOME"

# Perform (again) the laptop changes if enabled
if [ "$IS_LAPTOP" = true ]; then
    "$DOTFILES/scripts/ocbb-laptop_config.sh"
fi
