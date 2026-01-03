#!/bin/sh
set -e

# Uncomment laptop-specific blocks in i3blocks
sed -i 's|^##||g' "$HOME/.config/i3blocks/i3blocks.conf"
sed -i 's|^##||g' "$HOME/.config/i3/config"
