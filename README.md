# dotfiles

> ### TL;DR
> The two-liner commands to download and run the installer:
> ```
> xbps-install -Syu xbps curl
> curl -fsSL https://tinyurl.com/dfvinstall | sh
> ```
> `dfvinstall` _means "Dotfiles Void Install"._ <br>
> You may type it wrong, so I reserved `vdfinstall` as well, pointing to the same URL to avoid typos! 😀
>
> If you use a Brazilian ABNT2 keyboard, you may find it useful to load it: `loadkeys br-abnt2`. <br>
> Also, if you are inside the live CD, you already are root, but if you are running outside it, don't forget to run it with root privileges.

<img src="https://raw.githubusercontent.com/JuniorBecari10/df-installer/refs/heads/main/screenshot.png" />

_My desktop interface with the terminal open running Fastfetch._

## Overview

The dotfiles that I use in my personal Linux installation, along with some scripts to install them. <br />
The configurations in this repository are highly opinionated for my personal use, and may not fit the best for your needs.

You are free to edit the files yourself to your own desire.

The scripts this repository has can replicate exactly my personal Void Linux installation and configuration on any PC that can run the distro. The advantages of using it to install the system using `xbps` as opposed to inflating tarballs, is that it enables you to change and configure your installation to your needs and also getting the latest software provided by the package manager. This also makes optional installations possible.

This repository is meant to be kept in your home (`~`) folder even after the installation is complete, because you may want to make changes to it,
and it's already there for you to sync your configurations.

A clean installation made using this script should install roughly `598` packages. <br>
I'm still making efforts to lower this number, while keeping the same experience. If you know of some change that keeps the same experience while reducing the number of packages, please tell me.

## Specification

- **Distro**: Void Linux / glibc
- **Window Manager**: i3
- **Bar**: i3blocks
- **Lock Screen**: i3lock
- **Display Manager**: LightDM GTK Greeter
- **Display Server**: X.org
- **Bootloader**: GRUB
- **Code Editor**: Neovim / NVChad
- **Shell**: Bash
- **Audio Server**: PipeWire (with PulseAudio emulation)
- **Terminal Emulator**: kitty
- **Compositor**: xcompmgr
- **Init System**: runit
- **Locale**: PT-BR / UTF-8
- **Time Zone**: UTC-3
- **Boot Mode**: UEFI

### My wallpaper

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
`Mod + Shift + G`                 | Open Rofi emoji selector
`Mod + X`                         | Open Firefox
`Mod + P`                         | Open Power menu using Rofi


### Extra commands and aliases

All of these aliases and utilities are defined in `.bashrc`.

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
`lah`|`ls -lah`|Display the files one per line and also show hidden files, with the file sizes formatted to be more readable by humans.
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

### Custom utilities

#### `x` — XBPS wrapper

##### Install packages

| Command                     | Arguments | Description                                   |
| --------------------------- | --------- | --------------------------------------------- |
| `i`, `install`              | `<pkg>`   | Install packages with repo sync               |
| `iy`, `install-yes`         | `<pkg>`   | Install packages with repo sync (auto-yes)    |
| `ii`, `install-nosync`      | `<pkg>`   | Install packages without repo sync            |
| `iiy`, `install-nosync-yes` | `<pkg>`   | Install packages without repo sync (auto-yes) |

##### Remove

| Command            | Arguments | Description                                         |
| ------------------ | --------- | --------------------------------------------------- |
| `r`, `remove`      | `<pkg>`   | Remove packages and clear orphans                   |
| `ry`, `remove-yes` | `<pkg>`   | Remove packages and clear orphans (auto-yes)        |
| `rr`, `remove`      | `<pkg>`   | Remove packages and don't clear orphans            |
| `rry`, `remove-yes` | `<pkg>`   | Remove packages and don't clear orphans (auto-yes) |

##### Update & upgrade

| Command                   | Arguments | Description                           |
| ------------------------- | --------- | ------------------------------------- |
| `up`, `update`            | —         | Update repository index               |
| `u`, `upgrade`            | —         | Upgrade system                        |
| `uy`, `upgrade-yes`       | —         | Upgrade system (auto-yes)             |
| `fu`, `full-upgrade`      | —         | Update + upgrade + verbose            |
| `fuy`, `full-upgrade-yes` | —         | Update + upgrade + verbose (auto-yes) |

##### Search & info

| Command                        | Arguments | Description                     |
| ------------------------------ | --------- | ------------------------------- |
| `s`, `q`, `search`             | `<name>`  | Search repository packages      |
| `si`, `qi`, `search-installed` | —         | Search among installed packages |
| `info`                         | `<pkg>`   | Show package information        |

##### Reconfigure

| Command                   | Arguments | Description              |
| ------------------------- | --------- | ------------------------ |
| `rec`, `reconfigure`      | `<pkg>`   | Reconfigure a package    |
| `reca`, `reconfigure-all` | `<pkg>`   | Reconfigure all packages |

##### Orphans

| Command                     | Arguments | Description                         |
| --------------------------- | --------- | ----------------------------------- |
| `o`, `orphans`              | —         | List orphaned packages              |
| `ro`, `remove-orphans`      | —         | Remove orphaned packages            |
| `roy`, `remove-orphans-yes` | —         | Remove orphaned packages (auto-yes) |

##### Dependencies

| Command       | Arguments | Description               |
| ------------- | --------- | ------------------------- |
| `d`, `deps`   | `<pkg>`   | Show dependencies         |
| `rd`, `rdeps` | `<pkg>`   | Show reverse dependencies |

##### File ownership

| Command       | Arguments | Description                   |
| ------------- | --------- | ----------------------------- |
| `f`, `owns`   | `<file>`  | Which package owns this file? |
| `fl`, `files` | `<pkg>`   | List files of a package       |

##### Repository management

| Command            | Arguments | Description       |
| ------------------ | --------- | ----------------- |
| `rl`, `rep-list`   | —         | List repositories |
| `ra`, `rep-add`    | `<repo>`  | Add repository    |
| `rr`, `rep-remove` | `<repo>`  | Remove repository |

##### Updates

| Command              | Arguments | Description                   |
| -------------------- | --------- | ----------------------------- |
| `lu`, `list-updates` | —         | List packages that can update |
| `od`, `outdated`     | —         | Show outdated packages        |

---

#### `svc` — runit service control

##### Enable / Disable

| Command   | Arguments | Description       |
| ----------- | --------- | ----------------- |
| `enable`  | `<svc>`   | Enable service  |
| `disable` | `<svc>`   | Disable service |

##### Basic control

| Command   | Arguments | Description         |
| ----------- | --------- | ------------------- |
| `start`   | `<svc>`   | Start service     |
| `stop`    | `<svc>`   | Stop service      |
| `restart` | `<svc>`   | Restart service   |
| `status`  | `<svc>`   | Show service status |
| `log`     | `<svc>`   | View service logs   |

##### Advanced

| Command  | Arguments | Description                  |
| ---------- | --------- | ---------------------------- |
| `once`   | `<svc>`   | Start once (no respawn)      |
| `pause`  | `<svc>`   | Pause a service              |
| `cont`   | `<svc>`   | Resume a paused service      |
| `reload` | `<svc>`   | Reload service configuration |
| `hup`    | `<svc>`   | Send HUP signal              |
| `term`   | `<svc>`   | Send TERM signal             |
| `kill`   | `<svc>`   | Kill a service               |

##### Listing

| Command | Arguments | Description                        |
| --------- | --------- | ---------------------------------- |
| `list`  | —         | List enabled services              |
| `avail` | —         | List available service definitions |

##### Editing

| Command | Arguments | Description                             |
| --------- | --------- | --------------------------------------- |
| `edit`  | `<svc>`   | Edit the service run script (`$EDITOR`) |
> Use this as `EDITOR=<editor> sv edit <svc>`.

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

Before installing, make sure you have a stable internet connection. If you're using Wi-Fi, consider setupping it first using `wpa_cli` (`wpa_supplicant`).

### Automatic Installation
At the start of this file there's an one-liner command to run the script that downloads this repository and runs the installer. <br>
If you have already downloaded this repository, you just need to run `dotfiles/installer.sh`. **REMEMBER TO RUN THIS AS ROOT.**

### Manual Installation

1. Boot up the Void Linux live CD _with glibc_;
2. Set up the partitions using `cfdisk` according to this table (the script already handles the formatting):
   Type|Size|Format (FYI)
   ---|---|---
   Boot|1 GiB|FAT32
   Main|However you like (usually the rest of your drive)|ext4
   
   Take notes of the names of the partitions and their functions;
   > Remember: running this command will destroy any data you have inside the partitions,
   > so if you have meaningful data in there, consider make a backup first.
3. Get the `git` and `vim` (or `nano`) commands through `xbps-install -Syu xbps git vim` (or `nano`). `xbps` is there because it may need to be updated. If you're sure about it, then just run `xbps-install -S git vim`.
4. Clone the repository using `git clone https://github.com/JuniorBecari10/dotfiles` and enter into it using `cd dotfiles`;
5. Certify that all scripts have the _execute_ permission through `ls -la`, also check in the `scripts` folder _(optional)_;
6. Change your settings as you prefer by editing the `config.sh` file, using the code editor you have downloaded.
7. Once you are happy with your settings, run the `1-install.sh` script. Wait for it to complete. If there any errors, fix them (there's a section below called _Common Problems_ to explain some common errors and how to fix them), and if you think the error is in the installer, please open an Issue.
8. Reboot your computer, and if necessary, change in your BIOS settings to boot up your Void installation. Its name will probably be `Void` (or just `GRUB`). Fix any issues related to BIOS and booting, if necessary. Check _Common Problems_ if you need more help.
9. Log into i3 using your password.
10. Open the terminal (press `Mod (Windows key)` + `Enter`), enter the `dotfiles` folder (`cd dotfiles`) and run `2-post.sh`. It will perform some system changes, and will ask you for root permission; just type your password to allow it. It will open Firefox, there you can log into your account, and follow the instructions in the terminal to log into Git with your GitHub account.

> **Important** <br>
> Don't worry if you open the `dotfiles` folder and your config file is modified containing your passwords; as long as you don't push it, the `2-post.sh` script will use its information to run and then it resets the file to its defaults, allowing you to safely change your dotfiles and pushing them without any fear.

11. To properly apply the GTK theme to the bar's icons, log out and then log in back again. Press `Mod` + `P` and then select `Logout`, or, alternatively, press `Mod` + `Shift` + `E`, and select `Yes`. Log in back typing your password and pressing `Enter` afterward.

After this, you're good to go.

### Even more manual installation
You may also want to run the commands separately, or even audit the entire installer. If you want to do this, open the files (and edit them if you want) and do what your heart desires.

## Optional Installations

This script allows you to perform optional installations as well. Here's what they are, and what they do.

### Install NVIDIA drivers
Installs NVIDIA drivers into your system. Note that this installs the proprietary drivers (not the open-source `nouveau`), and thus it needs to enable the `nonfree` repository.

### Is Dual Boot
Enables `os-prober` and runs it during the GRUB configuration, so that your other OSs can also be selected.

### Is Laptop
Installs and configures laptop-specific stuff, such as brightness control and extra blocks in i3blocks, such as charging and brightness state.

### Bluetooth
Enables support for Bluetooth technology. Obviously, only enable this option if your device supports Bluetooth.

## Common Problems

During installations, especially in Void Linux ones, can occur many problems. Here's the list of the most common one and, also, their troubleshooting steps.

### BIOS doesn't recognize my Void installation

This script already adds your installation to the UEFI boot list, but some computers may still have this problem. Here's the steps to fix it.

1. Open the UEFI menu to manually add a boot entry;
2. Remember the number of the partition that you installed GRUB (the 1 GiB one), select its filesystem, and select to `\EFI\Void\grubx64.efi` (or alternatively, `\EFI\BOOT\BOOTX64.EFI`). Name the entry with the name of your choice. I'd recommend to name it as `Void Linux`;
3. Save the changes.

Now it should work. It not, you may want to enable the `GRUB_REMOVABLE` option, but if you have other OSs installed, this may remove their bootloader from the BIOS menu

Alternatively, you can also use `efibootmgr`. The complete command is in `scripts/1b-chroot.sh`. You may want to take a look at it.

### `os-prober` didn't find my other OS

`os-prober` under normal circumstances should not require mounting to work properly, but it may still fail to detect other OSs. So, you may want to mount them manually and run the utility while mounted. The steps to perform it are below:

1. Boot up again the Void Linux live CD;
2. _Chroot_ into your installation;
    1. Mount the main partition into `/mnt`: `mount /dev/sdX /mnt`, where `X` is your partition number;
    2. Mount the boot partition into `/mnt/boot/efi`: `mount /dev/sdX /mnt/boot/efi`, where `X` is your partition number;
    3. Run `xchroot /mnt`;
3. Mount the other OS' EFI partition, if it's only one, you can mount it directly into `/mnt`, otherwise, create subfolders, and mount each OS in one of them. It's important that all OSs are mounted at the same time. `mount /dev/sdX /mnt`;
4. Run `os-prober`, make sure it's run as `root`;
5. It should print the name of the other OSs. If so, patch the changes into GRUB by typing the following commands:
    ```
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Void
    grub-mkconfig -o /boot/grub/grub.cfg
    ```
6. Exit the chroot, and reboot your computer. In the GRUB menu, the other OSs should be listed.

### `xbps` cannot grab the packages because the mirror is out

This is a normal outage. Please try again in a few minutes.
