#!/bin/sh

# Source settings
. ./settings/general.sh
. ./settings/passwords.sh

# Set up filesystems
mkfs.vfat -F32 "$BOOT_PART"
mkswap "$SWAP_PART"
mkfs.ext4 "$MAIN_PART"

# Mount partitions
mount "$MAIN_PART" /mnt

mkdir -p /mnt/boot
mount "$BOOT_PART" /mnt/boot

swapon "$SWAP_PART"

# Perform base system installation
REPO="https://repo-default.voidlinux.org/current"

xbps-install -Sy -R "$REPO" -r /mnt base-system linux linux-firmware
xbps-install -Sy -r /mnt git vim grub-x86_64-efi efibootmgr

# Add network manager
xbps-install -Sy -r /mnt NetworkManager
ln -s /etc/runit/sv/NetworkManager /mnt/var/service/

# Generate fstab
cat <<EOF > /mnt/etc/fstab
$MAIN_PART  /        ext4  defaults  0 1
$BOOT_PART  /boot    vfat  defaults  0 2
$SWAP_PART  none     swap  sw        0 0
EOF

# Copy the general settings file into the installation
# The chroot script automatically deletes it.
cp ./settings/general.sh /mnt
chmod +x /mnt/general.sh

# Chroot into the system and run the the configuration commands
cat ./settings/general.sh ./settings/passwords.sh 1b-chroot.sh | chroot /mnt /bin/sh -s

# Remove the script from there
rm /mnt/general.sh

# Unmount all the drives under '/mnt'
umount -R /mnt
