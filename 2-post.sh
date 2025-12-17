#!/bin/sh
# This should be run after rebooting the computer, inside the WM, with you user, not as root.
set -e

~/dotfiles/scripts/2a-post.sh
echo "Done."
