#!/bin/sh
set -e

xbps-install -Sy os-prober

# Enable os-prober in GRUB
if grep -q '^GRUB_DISABLE_OS_PROBER=' /etc/default/grub; then
    sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
else
    echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
fi

os-prober || true
grub-mkconfig -o /boot/grub/grub.cfg
