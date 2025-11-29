#!/bin/sh

# Uncomment laptop-specific blocks in i3blocks
sed -i 's|##||g' ~/.config/i3blocks/i3blocks.conf
sed -i 's|##||g' ~/.config/i3/config
