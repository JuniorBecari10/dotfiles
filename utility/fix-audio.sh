#!/bin/sh
set -e

sudo udevadm trigger --subsystem-match=sound --action=add
sudo udevadm settle

# Just to check '+' after every output
ls -l /dev/snd
