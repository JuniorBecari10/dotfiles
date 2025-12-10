#!/bin/sh
set -e

xbps-install -Sy os-prober

# Enable os-prober in GRUB
sed -i 's/^#\(GRUB_DISABLE_OS_PROBER=\).*/\1false/; \
        t; \
        $a GRUB_DISABLE_OS_PROBER=false' /etc/default/grub

os-prober || true
grub-mkconfig -o /boot/grub/grub.cfg
