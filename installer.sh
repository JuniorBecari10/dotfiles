#!/bin/sh

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
CONFIG="./config.sh"

# Load config or create defaults
if [ -f "$CONFIG" ]; then
    . "$CONFIG"
else
cat > "$CONFIG" <<EOF
BOOT_PART="/dev/sda1"
MAIN_PART="/dev/sda2"

HOSTNAME="antonio-pc"
USERNAME="antonio"

INSTALL_NVIDIA_DRIVERS=false
IS_DUAL_BOOT=false
IS_LAPTOP=false
USE_GRUB_REMOVABLE=false
BLUETOOTH=false

GIT_USERNAME="Antônio Carlos"
GIT_EMAIL="antonioocarlos@proton.me"

ROOT_PASS=""
USER_PASS=""
EOF

. "$CONFIG"
fi

save_config() {
cat > "$CONFIG" <<EOF
BOOT_PART="$BOOT_PART"
MAIN_PART="$MAIN_PART"

HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"

INSTALL_NVIDIA_DRIVERS=$INSTALL_NVIDIA_DRIVERS
IS_DUAL_BOOT=$IS_DUAL_BOOT
IS_LAPTOP=$IS_LAPTOP
USE_GRUB_REMOVABLE=$USE_GRUB_REMOVABLE
BLUETOOTH=$BLUETOOTH

GIT_USERNAME="$GIT_USERNAME"
GIT_EMAIL="$GIT_EMAIL"

ROOT_PASS="$ROOT_PASS"
USER_PASS="$USER_PASS"
EOF
}

# Dialog helpers

ask() {
    dialog --inputbox "$1" 10 50 "$2" 2>&1 >/dev/tty
}

ask_password() {
    dialog --insecure --passwordbox "$1" 10 50 2>&1 >/dev/tty
}

ask_yesno() {
    if dialog --yesno "$1" 7 50 >/dev/tty 2>/dev/null; then
        printf '%s\n' true
    else
        printf '%s\n' false
    fi
}


# Menu Actions

partition_disks() {
    dialog --msgbox "Launching cfdisk. Partition your disks.\n\nPress ENTER to continue." 8 50
    clear

    cfdisk </dev/tty >/dev/tty 2>/dev/tty
    dialog --msgbox "cfdisk closed. Returning to installer." 7 40
}

edit_partitions() {
    BOOT_PART=$(ask "Boot partition (EFI)" "$BOOT_PART")
    MAIN_PART=$(ask "Root partition" "$MAIN_PART")
    save_config
}

edit_user_info() {
    HOSTNAME=$(ask "Hostname" "$HOSTNAME")
    USERNAME=$(ask "Username" "$USERNAME")
    save_config
}

edit_passwords() {
    ROOT_PASS=$(ask_password "Root password")
    USER_PASS=$(ask_password "User password")
    save_config
}

edit_git_info() {
    GIT_USERNAME=$(ask "Git username" "$GIT_USERNAME")
    GIT_EMAIL=$(ask "Git email" "$GIT_EMAIL")
    save_config
}

edit_system_flags() {
    INSTALL_NVIDIA_DRIVERS=$(ask_yesno "Install NVIDIA drivers?")
    IS_DUAL_BOOT=$(ask_yesno "Is this a dual-boot system?")
    IS_LAPTOP=$(ask_yesno "Is this a laptop?")
    USE_GRUB_REMOVABLE=$(ask_yesno "Install GRUB as removable (fallback)?")
    BLUETOOTH=$(ask_yesno "Enable Bluetooth support?")
    save_config
}

show_summary() {
    dialog --msgbox "
Partitions:
  BOOT: $BOOT_PART
  ROOT: $MAIN_PART

Users:
  Hostname: $HOSTNAME
  Username: $USERNAME

Options:
  NVIDIA drivers: $INSTALL_NVIDIA_DRIVERS
  Dual Boot: $IS_DUAL_BOOT
  Laptop: $IS_LAPTOP
  GRUB Removable: $USE_GRUB_REMOVABLE
  Bluetooth: $BLUETOOTH

Git:
  Username: $GIT_USERNAME
  Email: $GIT_EMAIL
" 26 60
}

do_install() {
    clear

    LOGFILE="/tmp/installer.log"
    : > "$LOGFILE"

    # Run installer with live output + logging
    (
        ./1-install.sh
        echo $? > /tmp/.install_status
    ) 2>&1 | tee "$LOGFILE"

    INSTALL_STATUS=$(cat /tmp/.install_status)
    rm -f /tmp/.install_status

    if [ "$INSTALL_STATUS" -ne 0 ]; then
        dialog --title "Installation Failed" \
               --textbox "$LOGFILE" 20 80

        dialog --title "Installer Error" \
               --msgbox "The installer exited with an error.\n\nLog saved to:\n$LOGFILE\n\nYou are still in live mode." \
               10 60
        clear
        return 1
    fi

    while true; do
        CHOICE=$(dialog --clear --stdout \
            --title "Installation Complete!" \
            --menu "Choose what to do next:" 15 60 5 \
            1 "Exit installer (stay in live system)" \
            2 "Reboot system now" \
            3 "Continue in chroot")

        case "$CHOICE" in
            1)
                clear
                exit 0
                ;;
            2)
                clear
                reboot
                ;;
            3)
                clear

                . config.sh

                mount "$MAIN_PART" /mnt
                mkdir -p /mnt/boot/efi
                mount "$BOOT_PART" /mnt/boot/efi
                swapon /mnt/swapfile || true

                xchroot /mnt /bin/sh
                ;;
        esac
    done
}

# Main Menu

main_menu() {
    while true; do
        CHOICE=$(dialog --clear --stdout --title "Installer Menu" --menu "Choose an option:" 18 60 10 \
            1 "Partition Disks (cfdisk)" \
            2 "Edit Partition Paths" \
            3 "User + Hostname" \
            4 "Edit Passwords" \
            5 "Git Configuration" \
            6 "System Options" \
            7 "Show Summary" \
            8 "Install" \
            9 "Exit")

        case "$CHOICE" in
            1) partition_disks ;;
            2) edit_partitions ;;
            3) edit_user_info ;;
            4) edit_passwords ;;
            5) edit_git_info ;;
            6) edit_system_flags ;;
            7) show_summary ;;
            8) do_install ;;
            9) clear; exit 0 ;;
        esac
    done
}

main_menu
