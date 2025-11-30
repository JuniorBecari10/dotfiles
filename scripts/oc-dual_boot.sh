#!/bin/sh
set -e

xbps-install -Sy os-prober
os-prober
update-grub
