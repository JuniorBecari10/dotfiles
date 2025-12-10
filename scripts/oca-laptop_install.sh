#!/bin/sh
set -e

PACKAGES="
brightnessctl
acpi
"

xbps-install -Sy $PACKAGES
