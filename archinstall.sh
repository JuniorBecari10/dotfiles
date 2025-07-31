#!/bin/sh

# This is a script to perform a minimal and opinionated Arch Linux installation, designed for my needs.
# Taken from this video: youtu.be/oeDbo-HRaZo

# It's recommended to run this script inside the Arch Linux live CD.
# Before running this script, make sure to set up the partitions manually (using 'cfdisk' utility is recommended) and also an internet connection.
# If you are using Wi-Fi, it's recommended to use the 'iwctl' utility.

# Define these variables using a text editor, like 'vim':
# After doing this, run this script as root (using 'sudo' or logged in as the root user).

# This script won't reboot automatically, so after running this, type 'reboot' to reboot your computer.
# Don't forget to change the boot priority order in your BIOS/UEFI configuration to your new installation.

# After that, log into your account, get the 'install.sh' script file, run it with sudo and then reboot again.
# After rebooting again and logging into i3, run the 'postconfig.sh' script and you're good to go.
# If you are in a laptop, run the 'laptopconfig.sh' script as well.

# --- Configurations ---

# Partitions and drives

BOOT_PART="/dev/sda1"
SWAP_PART="/dev/sda2"
MAIN_PART="/dev/sda3"

# --- Script ---

# Ensure the script is run with sudo/root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with 'sudo' or as root."
  echo "Try again with: 'sudo ./archinstall.sh'."
  exit 1
fi

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

# Copy chroot script file into the root of the new system
cp chroot.sh /mnt/
chmod +x /mnt/chroot.sh

# Chroot into the system and run the the configuration commands
arch-chroot /mnt ./chroot.sh

# Remove the script file
rm -rf /mnt/chroot.sh

# Unmount all the drives under '/mnt'
umount -R /mnt

echo "Done, you may reboot now."

