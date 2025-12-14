#!/bin/sh

CONFIG="./config.sh"

# --- Load config or create defaults ---
if [ -f "$CONFIG" ]; then
    . "$CONFIG"
else
cat > "$CONFIG" <<EOF
BOOT_PART="/dev/sda1"
SWAP_PART="/dev/sda2"
MAIN_PART="/dev/sda3"

HOSTNAME="host-pc"
USERNAME="user"

INSTALL_NVIDIA_DRIVERS=true
IS_DUAL_BOOT=false
IS_LAPTOP=false
USE_GRUB_REMOVABLE=false
BLUETOOTH=false

GIT_USERNAME="Git user"
GIT_EMAIL="email@git.com"

ROOT_PASS=""
USER_PASS=""
EOF

. "$CONFIG"
fi

save_config() {
cat > "$CONFIG" <<EOF
BOOT_PART="$BOOT_PART"
SWAP_PART="$SWAP_PART"
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

# --- Dialog helpers ---

ask() {
    dialog --inputbox "$1" 10 50 "$2" 2>&1 >/dev/tty
}

ask_password() {
    dialog --insecure --passwordbox "$1" 10 50 2>&1 >/dev/tty
}

ask_yesno() {
    if dialog --yesno "$1" 7 50; then
        echo true
    else
        echo false
    fi
}

# --- Menu Actions ---

partition_disks() {
    dialog --msgbox "Launching cfdisk. Partition your disks.\n\nPress ENTER to continue." 8 50
    clear

    cfdisk
    dialog --msgbox "cfdisk closed. Returning to installer." 7 40
}

edit_partitions() {
    BOOT_PART=$(ask "Boot partition (EFI)" "$BOOT_PART")
    SWAP_PART=$(ask "Swap partition" "$SWAP_PART")
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
  SWAP: $SWAP_PART
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
    ./1-install.sh

    dialog --msgbox "Installation complete! You can now reboot your system." 7 50
    clear
    exit 0
}

# --- Main Menu ---
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
