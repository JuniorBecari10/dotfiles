#!/bin/sh
set -e

DOTNET_DIR="/usr/share/dotnet"
DOTNET_BIN="/usr/bin/dotnet"

rm -fr "$DOTNET_DIR" "$DOTNET_BIN"
