#!/bin/sh

# Source settings
. ../settings/general.sh
. ../settings/passwords.sh

# Set up filesystems
mkfs.fat -F32 "$BOOT_PART"
mkswap "$SWAP_PART"
mkfs.ext4 "$MAIN_PART"

# Mount partitions
mount "$MAIN_PART" /mnt
mkdir -p /mnt/boot/efi

mount "$BOOT_PART" /mnt/boot/efi
swapon "$SWAP_PART"

# Perform base system installation
pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr networkmanager vim git

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Copy the general settings file into the installation
# The chroot script automatically deletes it.
cp ../settings/general.sh /mnt
chmod +x /mnt/general.sh

# Chroot into the system and run the the configuration commands
cat ../settings/general.sh ../settings/passwords.sh 1b-chroot.sh | arch-chroot /mnt /bin/bash -s

# Unmount all the drives under '/mnt'
umount -R /mnt
