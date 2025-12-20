#!/bin/sh
set -e

PACKAGES="
brightnessctl
acpi
xinput
"

xbps-install -Sy $PACKAGES
