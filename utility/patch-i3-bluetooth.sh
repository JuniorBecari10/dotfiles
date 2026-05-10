#!/bin/sh
set -e

sed -i 's|^### ||g' "$HOME/.config/i3blocks/i3blocks.conf"
sed -i 's|^### ||g' "$HOME/.config/i3/config"
