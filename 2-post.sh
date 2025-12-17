#!/bin/sh
# This should be run after rebooting the computer, inside the WM, with you user, not as root.
set -e

set -e

HOME="/home/$USERNAME"
SCRIPTS="$HOME/dotfiles/scripts"

"$SCRIPTS/2a-post.sh"
echo "Done."
