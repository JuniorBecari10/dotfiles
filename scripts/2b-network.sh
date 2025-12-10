#!/bin/sh
# Run this as root.
set -e

# Fix broken symlink for DNS
ln -sf /run/NetworkManager/resolv.conf /etc/resolv.conf
