#!/bin/sh

# Please don't call this script manually. 'archinstall.sh' will execute it inside chroot.

# --- Configurations ---

# Users and passwords (passwords are omitted for security purposes)

HOSTNAME="antonio-pc"
ROOT_PASS=""

USERNAME="antonio"
USER_PASS=""

GRUB_DRIVE="/dev/sda"

# --- Script ---

# Sync date (São Paulo, Brazil: UTC-3)
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Sync system clock with the hardware one
hwclock --systohc

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen

echo "LANG=pt_BR.UTF-8" > /etc/locale.conf

# Set keymap to Brazilian ABNT2 keyboard
echo "KEYMAP=br-latin1-abnt2" > /etc/vconsole.conf

# Set up hostname and root password

echo "$HOSTNAME" > /etc/hostname
echo "root:$ROOT_PASS" | chpasswd

# Set up user
useradd -m -G wheel -s /bin/bash "$USERNAME"
echo "$USERNAME:$USER_PASS" | chpasswd

# Enable sudo for wheel group
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/99-wheel
chmod 440 /etc/sudoers.d/99-wheel

# Enable core systemd services
systemctl enable NetworkManager

# Set up grub bootloader
grub-install $GRUB_DRIVE
grub-mkconfig -o /boot/grub/grub.cfg

# We could set up dual booting here, but let's leave it to the user to decide.
# This includes enabling OS prober, actually probing, and then writing to the GRUB configuration file.
