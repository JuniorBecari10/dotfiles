#!/bin/sh
# This should be run in the live CD.
set -e

# Source settings
. ./config.sh

if ./scripts/1a-install.sh; then
    echo "(!) Installation completed successfully!"
    echo "You may reboot your computer."
else
    swapoff /mnt/swapfile 2>/dev/null || true
    if ! umount -R /mnt 2>/dev/null; then
        echo "Normal unmount failed, using lazy unmount..."
        umount -Rl /mnt
    fi

    echo "(X) Installation failed."
    echo "Check the log above for errors, fix them, and then run the installer again."
    echo "If you think this is an error in the script, please open an Issue."
fi
