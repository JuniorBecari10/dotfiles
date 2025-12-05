# dotfiles

The dotfiles that I use in my personal Linux PC, along with some scripts to install them. <br />
The configurations in this repository are highly opinionated for my personal use, and may not fit the best for your needs.

You are free to edit the files yourself to fit better your needs.

The scripts this repository has can replicate exactly my personal Void Linux installation and configuration on any PC that can run it.

The Void Linux installation itself is very minimal, installing roughly X packages, with no WM or DE. <br />
When the WM and the programs are installed, the number of packages goes up to roughly Y (Xorg has many dependencies).

This repository is meant to be kept in your home (`~`) folder even after the installation is complete, because you may want to make changes to it,
and it's already there for you to sync your configurations.

## Specification

- **Distro**: Void Linux / _glibc_
- **Window Manager**: i3
- **Bar**: i3blocks with custom blocks
- **Lock Screen**: i3lock
- **Display Manager**: LightDM GTK Greeter
- **Bootloader**: GRUB
- **Code Editor**: Neovim / NVChad
- **Audio Server**: PipeWire
- **Terminal Emulator**: kitty
- **Compositor**: picom
- **Init System**: runit

### My wallpaper:

<img src="files/.config/wallpaper.jpg" width=500 /> <br />
_This is the default wallpaper on Archcraft._

### Keybinds

Modifier: `Win`

Keybinding|Action
---|---
`Mod + D`                         | Run `rofi`
`Mod + Shift + D`                 | Run `rofi` for Flatpak apps
`Mod + J` / `Mod + Left`          | Move focus left
`Mod + K` / `Mod + Down`          | Move focus down
`Mod + L` / `Mod + Up`            | Move focus up
`Mod + ;` / `Mod + Right`         | Move focus right
`Mod + Shift + J` / `Mod + Left`  | Move window left
`Mod + Shift + K` / `Mod + Down`  | Move window down
`Mod + Shift + L` / `Mod + Up`    | Move window up
`Mod + Shift + ;` / `Mod + Right` | Move window right
`Mod + H`                         | Switch to horizontal orientation (new windows appear right)
`Mod + V`                         | Switch to vertical orientation (new windows appear below)
`Mod + E`                         | Toggle between horizontal and vertical orientation
`Mod + F`                         | Toggle fullscreen for focused container
`Mod + S`                         | Set mode to stacking
`Mod + W`                         | Set mode to tabbed
`Mod + Shift + Space`             | Toggle floating window
`Mod + Space`                     | Toggle focus between tiling and floating windows
`Mod + A`                         | Focus parent container
`Mod + 1`-`0`                     | Focus workspace 1–10
`Mod + Shift + 1`-`0`             | Move focused window to workspace 1–10
`Mod + Shift + Z`                 | Move workspace to left monitor
`Mod + Shift + X`                 | Move workspace to right monitor
`Mod + Shift + C`                 | Reload i3
`Mod + Shift + R`                 | Restart i3
`Mod + Shift + E`                 | Exit i3 (log out of X session)
`Mod + B`                         | Open Clipman clipboard tool
`Mod + R`                         | Toggle resize mode
`J` / `Left` *(resize mode)*      | Shrink width by 10px
`;` / `Up` *(resize mode)*        | Grow width by 10px
`K` / `Down` *(resize mode)*      | Grow height by 10px
`L` / `Up` *(resize mode)*        | Shrink height by 10px
`Mod + Enter`                     | Open `kitty` terminal
`Mod + Q`                         | Close current window
`PrintScr`                        | Flameshot interactive screenshot
`Shift + PrintScr`                | Flameshot fullscreen screenshot to clipboard
`Ctrl + PrintScr`                 | Flameshot fullscreen screenshot to file (`~/Pictures`)
`Mod + N`                         | Lock screen with `i3lock`
`Mod + G`                         | Open Thunar file explorer
`Mod + X`                         | Open Firefox
`Mod + P`                         | Open Power menu using Rofi


### Extra commands and aliases

- Aliases

**Command**|**Alias to**|**Description**
---|---|---
`grep`|`grep --color=auto`|Regular `grep` with color. It only prints matching lines.
`grepc`|`grep --color=always -e "^" -e`|Regular `grep`, but print all lines, highlighting the matches.
`greprn`|`grep -rn`|Traverses recursively and prints file and line/number info of all matches.
`feh`|`feh --geometry 1100x700`|Regular `feh`, but with set window bounds.
`fehe`|`feh --edit`|`feh` with image edit mode toggled on.
`ls`|`ls --color=auto`|Regular `ls` with color.
`ll`|`ls -l`|Display the files one per line.
`la`|`ls -la`|Display the files one per line and also show hidden files.
`nv`|`nvim`|Shortcut for the `nvim` command.
`ff`|`fastfetch`|Shortcut for the `fastfetch` command.
`fsi`|`dotnet fsi`|Shortcut for the `dotnet fsi` subcommand.
`fsx`|`fsi`|Typo guard for the `fsi` alias.

- Extra commands (functions)

**Command**|**What it does**
---|---
`gac <message>`|`git add` and `git commit -m <message>`.
`gacp <message>`|`git add`, `git commit -m <message>` and `git push`.
`mkcd <path>`|`mkdir -p <path>` and `cd <path>`.
`xcopy`|`xclip -selection clipboard`.
`xpaste`|`xclip -selection clipboard -o`.
`sv-enable <svc>`|`sudo ln -sf "/etc/sv/<svc>" /var/service/`.
`sv-disable <svc>`|`sudo rm "/var/service/<svc>"`.

### System tray icons

- NetworkManager
- volumeicon
- XFCE Clipman

### i3blocks' blocks I use

All of them are from [here](https://github.com/vivien/i3blocks-contrib).

- `calendar` (original: `time`, modified)
- `brightness` (laptop-specific, modified)
  
  > This block, in the original repository, requires you to compile the helper program, `brightness`, from its source code in C.
  > This repository contains both the (modified) source code with its original Makefile,
  > along with an extra script to move the binary to the right place.
  > An up-to-date compiled version of it is already in place. But the source code is here as well, so you can make modifications and replace the original one if you want.
- `battery` (laptop-specific)

## My Neovim extensions

> **Note** <br />
>
> They aren't installed out-of-the-box. The script is already there to handle them gracefully, but you still have to run `:MasonInstall <extension>`.

- bash-language-server
- clangd
- css-lsp
- emmet-language-server
- fsautocomplete
- gopls
- html-lsp
- lua-language-server
- pyright
- sqls
- tailwindcss-language-server
- typescript-language-server
- vue-language-server

## How to Install

Before installing, make sure you have a stable internet connection. If you're using Wi-Fi, consider setupping it first using `iwctl`.

1. Boot up the Void Linux live CD _with glibc_;
2. Set up the partitions using `cfdisk` according to this table (the script already handles the formatting):
   Type|Size|Format (FYI)
   ---|---|---
   Boot|1 GiB|FAT32
   Swap|At least 2 GiB|Swap
   Main|However you like (usually the rest of your drive)|ext4
   
   Take notes of the names of the partitions and their functions;
   > Remember: running this command will destroy any data you have inside the partitions,
   > so if you have meaningful data in there, consider make a backup first.
4. Get the `git` command through `xbps-install -Sy git`.
5. Clone the repository using `git clone https://github.com/JuniorBecari10/dotfiles` and enter into it using `cd dotfiles`;
6. Certify that all scripts have the _execute_ permission through `ls -la`, also check in the `scripts` folder;
7. Change your settings as you prefer by editing the `settings/general.sh` and `settings/passwords.sh` files.
8. Once you are happy with your settings, run the `install.sh` script.
9. Reboot your computer, and if necessary, change in your BIOS settings to boot up your Void installation. Its name will probably be `Void`. Fix any issues related to BIOS and booting, if necessary. Check _Common Problems_ if you need more help.
10. Log into i3 using your password.
11. Open the terminal (press `Mod (Win)` + `Enter`), enter the `dotfiles` folder (`cd dotfiles`) and run `post.sh` with `sudo`. It will open Firefox, log into your account, and follow the instructions in the terminal to log Git into your GitHub account.

You're good to go.

## Optional Installations

This script allows you to perform optional installations as well. Here's what they are, and what they do.

### Install NVIDIA drivers
Installs NVIDIA drivers into your system.

### Is Dual Boot
Enables `os-prober` and runs it during the GRUB configuration, so that your other OSs can also be booted up. <br />
This configuration has an extra variable, OTHER_EFI_PART, which is the EFI partition of the other operating system you want to dual boot too. This is necessary, since `os-prober` doesn't usually find it if it's unmounted, so it'll be used to mount it temporarily, run `os-prober`, and then unmount.

If you haven't checked this option that variable has no use, and therefore it won't hrm your installation. <br />
In the future this might be an array.

### Is Laptop
Installs and configures laptop-specific stuff, such as brightness control, extra blocks in i3blocks, such as charging and brightness state.

## Common Problems

During installations, especially in Void Linux ones, can occur many problems. Here's the list of the most common one and, also, their troubleshooting steps.

### BIOS doesn't recognize my Void installation

Some computers may have this problem. Here's the steps to fix it.

1. Open the menu to manually add a boot entry;
2. Remember the number of the partition that you installed GRUB (the 1 GiB one), select its filesystem, and select to `\EFI\Void\grubx64.efi`. Name the entry with the name of your choice;
3. Save the changes.

Now it should work.

### `os-prober` didn't find my other OS

This script is prepared for this case, but if it still fails, do the following:

> Note: this is exactly what the script does, but if it's done manually, one can troubleshoot better the problem and fix it.

1. Boot up again the Void Linux live CD;
2. _Chroot_ into your installation;
    1. Mount the main partition into `/mnt`: `mount /dev/sdX /mnt`, where `X` is your partition number;
    2. Mount the EFI (boot) partition into `/mnt/boot/efi`: `mount /dev/sdX /mnt/boot/efi`, where `X` is your partition number;
    3. Run `chroot /mnt`;
3. Mount the other OS' EFI partition, if it's only one, you can mount it directly into `/mnt`, otherwise, create subfolders, and mount each OS in one of them. It's important that all OSs are mounted at the same time. `mount /dev/sdX /mnt`;
4. Run `os-prober`, make sure it's run as `root`;
5. It should print the name of the other OSs. If so, patch the changes into GRUB by typing the following commands, and then, you're good to go. Exit the chroot, and reboot your computer. In the GRUB menu the other OSs should be listed.
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Void
grub-mkconfig -o /boot/grub/grub.cfg
```
