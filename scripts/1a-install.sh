#!/bin/sh
set -e

# Source settings
. config/general.sh
. config/passwords.sh

# Set up filesystems
mkfs.fat -F32 "$BOOT_PART"
mkswap "$SWAP_PART"
mkfs.ext4 -F "$MAIN_PART"

# Mount partitions
mount "$MAIN_PART" /mnt
mkdir -p /mnt/boot/efi
mount "$BOOT_PART" /mnt/boot/efi
swapon "$SWAP_PART" || true

# Perform base system installation
REPO="https://repo-default.voidlinux.org/current"
yes | xbps-install -Sy -R "$REPO" -r /mnt base-system linux linux-firmware git vim grub-x86_64-efi efibootmgr base-devel

# Generate fstab
xgenfstab -U /mnt > /mnt/etc/fstab

# Copy the general settings file into the installation; the chroot script automatically deletes it.
cp config/general.sh /mnt/general.sh
chmod +x /mnt/general.sh

# Chroot into the system and run the the configuration commands
cat config/general.sh config/passwords.sh scripts/1b-chroot.sh | xchroot /mnt /bin/sh -s

# Unmount all the drives under '/mnt'
umount -R /mnt
