#!/bin/sh
set -e

# Install latest .NET SDK LTS
DOTNET_DIR="/usr/share/dotnet"
DOTNET_BIN="/usr/bin/dotnet"

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh

./dotnet-install.sh --channel LTS --install-dir "$DOTNET_DIR"

ln -sf "$DOTNET_DIR/dotnet" "$DOTNET_BIN"
rm dotnet-install.sh
