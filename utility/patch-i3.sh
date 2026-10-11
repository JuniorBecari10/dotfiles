#!/bin/sh
set -e

# TODO: make step 1 mandatory and 2 and 3 optional and interchangeable,
# because not all computers with bluetooth support will be laptops.

usage() {
    echo "Usage: $0 [p|pc | l|laptop | b|bluetooth]"
    echo "  Runs the stages in order (pc -> laptop -> bluetooth) and stops after the given one."
    echo "  No argument shows this message."
    exit 1
}

stage_pc() {
    echo "1. PC"

    cp -f ~/dotfiles/files/.config/i3/config ~/.config/i3/config
    cp -f ~/dotfiles/files/.config/i3blocks/i3blocks.conf ~/.config/i3blocks/i3blocks.conf
}

stage_laptop() {
    echo "2. Laptop"

    ~/dotfiles/scripts/ocbb-laptop_config.sh
}

stage_bluetooth() {
    echo "3. Bluetooth"

    sed -i 's|^### ||g' "$HOME/.config/i3blocks/i3blocks.conf"
    sed -i 's|^### ||g' "$HOME/.config/i3/config"
}

[ $# -eq 1 ] || usage

case "${1}" in
    p|pc)        last=1 ;;
    l|laptop)    last=2 ;;
    b|bluetooth) last=3 ;;
    *)           usage ;;
esac

[ "$last" -ge 1 ] && stage_pc
[ "$last" -ge 2 ] && stage_laptop
[ "$last" -ge 3 ] && stage_bluetooth

exit 0
