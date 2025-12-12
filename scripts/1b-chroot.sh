#!/bin/sh
set -e

REPO_URL="https://github.com/JuniorBecari10/dotfiles"
export HOME="/home/$USERNAME"

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
printf "%s\n%s\n" "$ROOT_PASS" "$ROOT_PASS" | passwd

# Set up user and add it to the 'wheel' group
useradd -m -g users -G wheel,video,audio,input,plugdev,network -s /bin/bash "$USERNAME"
printf "%s\n%s\n" "$USER_PASS" "$USER_PASS" | passwd "$USERNAME"

# Enable sudo for wheel
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/99-wheel
chmod 440 /etc/sudoers.d/99-wheel

# Set up GRUB bootloader for UEFI
grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id="Void" \
    --recheck \
    ${USE_GRUB_REMOVABLE:+--removable}

grub-mkconfig -o /boot/grub/grub.cfg

# Download dotfiles
git clone "$REPO_URL" "$HOME/dotfiles"
chown -R "$USERNAME" "$HOME/dotfiles"

# Run config scripts
"$HOME/dotfiles/scripts/1c-xbps.sh"
"$HOME/dotfiles/scripts/1d-services.sh"
"$HOME/dotfiles/scripts/1e-pipewire.sh"
"$HOME/dotfiles/scripts/1f-patch.sh"
"$HOME/dotfiles/scripts/1g-flatpak.sh"

# Optional installs
[ "$IS_DUAL_BOOT" = true ] && "$HOME/dotfiles/scripts/ob-dual_boot.sh"

if [ "$IS_LAPTOP" = true ]; then
    "$HOME/dotfiles/scripts/oca-laptop_install.sh"
    "$HOME/dotfiles/scripts/ocb-laptop_config.sh"
fi

[ "$INSTALL_NVIDIA_DRIVERS" = true ] && "$HOME/dotfiles/scripts/oa-nvidia_drivers.sh"

# Finalize the core installation, building the initramfs
# Optimize if the NVIDIA drivers option is enabled, so it builds the initramfs only once
[ "$INSTALL_NVIDIA_DRIVERS" = false ] && xbps-reconfigure -fa

# Delete config file
rm -rf /general.sh
