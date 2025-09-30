#!/bin/sh

REPO_URL="https://github.com/JuniorBecari10/dotfiles"
HOME="/home/$USERNAME"

# Sync date (São Paulo, Brazil: UTC-3)
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Sync system clock with the hardware one
hwclock --systohc

# Set locale
sed -i "s/^#\(en_US.UTF-8 UTF-8\)/\1/" /etc/locale.gen
sed -i "s/^#\(pt_BR.UTF-8 UTF-8\)/\1/" /etc/locale.gen

locale-gen

echo "LANG=pt_BR.UTF-8" > /etc/locale.conf

# Set keymap to Brazilian ABNT2 keyboard
echo "KEYMAP=br-latin1-abnt2" > /etc/vconsole.conf

# Set up hostname and root password

echo "$HOSTNAME" > /etc/hostname
echo "root:$ROOT_PASS" | chpasswd

# Set up user, adding it to the 'wheel' group
useradd -m -G wheel -s /bin/bash "$USERNAME"
echo "$USERNAME:$USER_PASS" | chpasswd

# Enable sudo for 'wheel' group
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/99-wheel
chmod 440 /etc/sudoers.d/99-wheel

# Enable services
systemctl enable NetworkManager

# Set up GRUB bootloader for UEFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg

# ---

# Download dotfiles folder to perform post-installation
git clone "$REPO_URL" "$HOME/dotfiles"

# Copy it and then delete
cp -f /general.sh "$HOME/dotfiles/settings/general.sh"
rm -rf /general.sh

# Set up config files
"$HOME/dotfiles/scripts/1c-user.sh"
"$HOME/dotfiles/scripts/1d-patch.sh"

# Optional Installations

# a. Install NVIDIA drivers
if [ "$INSTALL_NVIDIA_DRIVERS" = true ]; then
    "$HOME/dotfiles/scripts/oa-nvidia_drivers.sh"
fi

# b. Install Yay
if [ "$INSTALL_YAY" = true ]; then
    "$HOME/dotfiles/scripts/ob-install_yay.sh"
fi

# c. Dual Boot
if [ "$INSTALL_YAY" = true ]; then
    "$HOME/dotfiles/scripts/oc-dual_boot.sh"
fi

# d. Laptop
if [ "$INSTALL_YAY" = true ]; then
    "$HOME/dotfiles/scripts/od-laptop.sh"
fi
