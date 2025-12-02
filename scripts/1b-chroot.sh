#!/bin/sh

REPO_URL="https://github.com/JuniorBecari10/dotfiles"
HOME="/home/$USERNAME"

# Sync date (São Paulo, Brazil: UTC-3). Hardware clock doesn't need to be set here.
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Set locale
sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/default/libc-locales
sed -i 's/^#\(pt_BR.UTF-8 UTF-8\)/\1/' /etc/default/libc-locales

xbps-reconfigure -f glibc-locales

# Set language to Portuguese and keymap to Brazilian ABNT2 keyboard
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

# Set up hostname and root password
echo "$HOSTNAME" > /etc/hostname
echo "root:$ROOT_PASS" | chpasswd

# Set up user and user password, adding it to the 'wheel' group
useradd -m -G wheel,video,audio -s /bin/bash "$USERNAME"
echo "$USERNAME:$USER_PASS" | chpasswd

# Enable sudo for 'wheel' group
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/99-wheel
chmod 440 /etc/sudoers.d/99-wheel

# Set up GRUB bootloader for UEFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"
grub-mkconfig -o /boot/grub/grub.cfg

# Finalize the core installation
xbps-reconfigure -fa

# ---

# Download dotfiles folder to perform post-installation
git clone "$REPO_URL" "$HOME/dotfiles"

# Set up config files
"$HOME/dotfiles/scripts/1c-xbps.sh"
"$HOME/dotfiles/scripts/1d-services.sh"
"$HOME/dotfiles/scripts/1e-patch.sh"

# Move user configs to the installation's dotfiles folder
mv -f /general.sh "$HOME/dotfiles/config/general.sh"

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
if [ "$IS_DUAL_BOOT" = true ]; then
    "$HOME/dotfiles/scripts/oc-dual_boot.sh"
fi

# d. Laptop
if [ "$IS_LAPTOP" = true ]; then
    "$HOME/dotfiles/scripts/oda-laptop_install.sh"
    "$HOME/dotfiles/scripts/odb-laptop_config.sh"
fi
