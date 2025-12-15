#!/bin/sh
set -e

# Source settings
. ./config.sh

# Set up filesystems
mkfs.fat -F32 "$BOOT_PART"
mkfs.ext4 -F "$MAIN_PART"

# Mount partitions
mount "$MAIN_PART" /mnt
mkdir -p /mnt/boot/efi
mount "$BOOT_PART" /mnt/boot/efi

# Create swapfile of 4GB
fallocate -l 4G /mnt/swapfile
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile || true

# Perform base system installation
REPO="https://repo-default.voidlinux.org/current"
yes | xbps-install -Sy -R "$REPO" -r /mnt base-system linux linux-firmware git vim grub-x86_64-efi efibootmgr base-devel

# Generate fstab
xgenfstab -U /mnt > /mnt/etc/fstab

# Copy the settings file into the installation; the chroot script automatically deletes it.
cp ./config.sh /mnt/config.sh
chmod +x /mnt/config.sh

# Chroot into the system and run the the configuration commands
cat ./config.sh scripts/1b-chroot.sh | xchroot /mnt /bin/sh -s

# Unmount all the drives under '/mnt'
swapoff /mnt/swapfile
umount -R /mnt
