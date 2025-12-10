#!/bin/sh
set -e

PACKAGES="
brightnessctl
acpi
python3
"

xbps-install -Sy $PACKAGES
