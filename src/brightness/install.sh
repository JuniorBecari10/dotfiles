#!/bin/sh

# This script compiles and moves the binary to i3blocks folder.
# It also runs make, so you don't need to compile it separately.

make release
mv ./bin/brightness ~/.config/i3blocks/brightness
