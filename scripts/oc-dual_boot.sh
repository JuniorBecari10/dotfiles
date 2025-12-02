#!/bin/sh
set -e

xbps-install -Sy os-prober
os-prober || true
grub-mkconfig -o /boot/grub/grub.cfg
