#!/bin/sh

PACKAGES="
brightnessctl
acpi
python3
"

xbps-install -Sy $PACKAGES
