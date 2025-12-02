#!/bin/sh

# Source settings
. config/general.sh
. config/passwords.sh

# Set up filesystems
mkfs.fat -F32 "$BOOT_PART"
mkswap "$SWAP_PART"
mkfs.ext4 "$MAIN_PART"

# Mount partitions
mount "$MAIN_PART" /mnt
mount --mkdir "$BOOT_PART" /mnt/boot/efi
swapon "$SWAP_PART"

# Perform base system installation
REPO="https://repo-default.voidlinux.org/current"
xbps-install -Sy -R "$REPO" -r /mnt base-system linux linux-firmware git vim grub-x86_64-efi efibootmgr base-devel

# Enable some services (test without them first)
# ln -s /etc/runit/sv/dbus /mnt/var/service/
# ln -s /etc/runit/sv/acpid /mnt/var/service/
# ln -s /etc/runit/sv/udevd /mnt/var/service/

# Generate fstab
xgenfstab -U /mnt > /mnt/etc/fstab

# Copy the general settings file into the installation, to keep it there for the user
# The chroot script automatically deletes it.
cp config/general.sh /mnt
chmod +x /mnt/general.sh

# Chroot into the system and run the the configuration commands
cat config/general.sh config/passwords.sh scripts/1b-chroot.sh | xchroot /mnt /bin/sh -s

# Unmount all the drives under '/mnt'
umount -R /mnt
