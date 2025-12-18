#!/bin/sh
set -e

URL="https://github.com/lassekongo83/adw-gtk3/releases/download/v6.4/adw-gtk3v6.4.tar.xz"
DEST="$HOME/.local/share/themes"
TMP="/tmp/adw-gtk3.tar.xz"

mkdir -p "$DEST"

echo "Downloading adw-gtk3..."
curl -L "$URL" -o "$TMP"

echo "Extracting theme..."
tar -xf "$TMP" -C "$DEST"

rm -f "$TMP"

echo "adw-gtk3 installed to $DEST"
