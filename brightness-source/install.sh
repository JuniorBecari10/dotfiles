#!/bin/sh

# This script compiles and moves the binary to i3blocks folder.

make release
mv ./bin/brightness ~/.config/i3blocks/brightness
