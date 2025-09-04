# dotfiles

The dotfiles that I use in my personal Linux PC, along with some scripts to install them. <br />
The configurations in this repository are highly opinionated for my personal use, and may not fit the best for your needs.

You are free to edit the files yourself to better fit your needs.

The scripts this repository has can replicate exactly my personal Arch Linux installation and configuration on any PC that runs Arch Linux.

This means that the Arch Linux installation _itself_ is also installed through scripts;
they use the same commands used when performing a manual installation (without `archinstall`).

The Arch Linux installation itself is very minimal, installing roughly 190 packages, with no Window Manager or Display Manager. <br />
When the WM and the programs are installed, the number of packages goes up to roughly 580.

## Specification

- **Distro**: Arch Linux
- **Window Manager**: i3
- **Bar**: i3blocks with custom blocks
- **Lock Screen**: i3lock
- **Display Manager**: LightDM GTK Greeter
- **Bootloader**: GRUB
- **Code Editor**: Neovim with NVChad
- **Terminal Emulator**: kitty

### My wallpaper:

<img src=".config/wallpaper.jpg" width=500 /> <br />
_This is the default wallpaper on Archcraft._

### Keybinds

Modifier: `Win`

- `Mod` + `D`: Run `rofi`

- `Mod` + `J` or `Mod` + `Left`: Move focus left
- `Mod` + `K` or `Mod` + `Down`: Move focus down
- `Mod` + `L` or `Mod` + `Up`: Move focus up
- `Mod` + `;` or `Mod` + `Right`: Move focus right

- `Mod` + `Shift` + `J` or `Mod` + `Left`: Move window left
- `Mod` + `Shift` + `K` or `Mod` + `Down`: Move window down
- `Mod` + `Shift` + `L` or `Mod` + `Up`: Move window up
- `Mod` + `Shift` + `;` or `Mod` + `Right`: Move window right

- `Mod` + `H`: Switch to horizontal orientation (new windows will appear at the right side)
- `Mod` + `V`: Switch to vertical orientation (new windows will appear below)
- `Mod` + `E`: Toggle between them

- `Mod` + `F`: Toggle fullscreen to the focused container (group of windows)

- `Mod` + `S`: Set mode to stacking
- `Mod` + `W`: Set mode to tabbed

- `Mod` + `Shift` + `Space`: Toggle floating window
- `Mod` + `Space`: Toggle focus between tiling and floating windows

- `Mod` + `A`: Focus parent container
- ~`Mod` + `D`: Focus child container~ _(disabled)_

- `Mod` + [`1`-`0`]: Focus workspace from 1 to 10
- `Mod` + `Shift` + [`1`-`0`]: Move focused window to workspace from 1 to 10

- `Mod` + `Shift` + `Z`: Move workspace to the monitor on the left side
- `Mod` + `Shift` + `X`: Move workspace to the monitor on the right side

- `Mod` + `Shift` + `C`: Reload i3
- `Mod` + `Shift` + `R`: Restart i3
- `Mod` + `Shift` + `E`: Exit i3, logging you out from the X Session

- `Mod` + `R`: Toggle resize mode

---

While in resize mode:
- `J` or `Left`: Shrink width by 10px
- `;` or `Up`: Grow width by 10px

- `K` or `Down`: Grow height 10px
- `L` or `Up`: Shrink height 10px

---

- `Mod` + `Enter`: Open `kitty` terminal
- `Mod` + `Q`: Close current window

- `PrintScr`: Take screenshot using `flameshot` with interactive area selector and options
- `Shift` + `PrintScr`: Take screenshot fullscreen using `flameshot` and put it to clipboard
- `Ctrl` + `PrintScr`: Take screenshot fullscreen using `flameshot` and put it as a file in `~/Pictures`

- `Mod` + `N`: Lock screen using `i3lock`
- `Mod` + `G`: Open Thunar, a GUI file explorer
- `Mod` + `X`: Open Firefox
- `Mod` + `P`: Open Power menu using Rofi

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
  > A compiled version of it is already in place.
- `battery` (laptop-specific)

## How to Install

1. Boot up the Arch Linux live CD;
2. Set up the partitions using `cfdisk` according to this table (the script already handles the formatting):
   Type|Size|Format (FYI)
   ---|---|---
   Boot|1 GiB|FAT32
   Swap|It's recommended to be at least 2 GiB|Swap
   Main|However you like (usually the rest of your drive)|ext4
   
   Take notes of the names of the partitions and their functions;
   > Remember: running this command will destroy any data you have inside the partitions,
   > so if you have meaningful data in there, consider make a backup first.
4. Get the `git` command through `pacman -Sy git`.
5. Clone the repository using `git clone https://github.com/JuniorBecari10/dotfiles` and enter into it using `cd dotfiles`;
6. Certify that all scripts have the _execute_ permission through `ls -la`;
7. Open the `archinstall.sh` script using `vim` or `nano` and replace the partition names accordingly to your PC, using your annotations you wrote while you used `cfdisk`;
   > You may not have used `cfdisk`; the partitions may already be correct already.
9. Save the file and exit the editor;
10. Open `chroot.sh` using your editor of preference and edit the variables: the hostname, your username, the root password and your password.
    > Note: it is _safe_ to write your password in this file if you don't share it, since the live CD's storage is on RAM, and upon rebooting it's destroyed.
11. Run `./archinstall.sh`;
    > Remember: running this command will destroy any data you have inside the partitions, if you haven't run `cfdisk`, or have formatted them before.
    > If you still have meaningful data in there, consider make a backup first.
12. When it finishes, you can reboot your computer using the `reboot` command;
13. Before your PC turns on again, make sure to select your new Arch installation in the BIOS menu;
14. When it turns on again, you'll be taken to the TTY; log into your account by typing in your username and password;
15. Clone the repository _again_ by using `git clone https://github.com/JuniorBecari10/dotfiles` and enter into it using `cd dotfiles`;
16. Run `sudo ./install.sh`, and then type in your password;
    > Run this with `sudo`; **_do not_** log into the root account first. Make sure to be logged into your personal user.
17. Reboot the computer using `sudo reboot`.
18. After rebooting, log into i3 using your password (your account should have been selected);
19. If you have more than one monitor, follow these steps:
    1. Launch `arandr` through rofi: Press Windows + D, then type `arandr` and press Enter;
    2. Arrange your monitors however you like;
    3. To make changes persistent, save the file by clicking in _Save As_, type the name as `~/.sl.sh` and press Enter;
    4. Restart i3 by pressing Windows + Shift + R, and see if the changes persist.
21. Open a terminal window using Windows + Enter. This will open kitty.
22. Enter the _dotfiles_ folder by typing `cd dotfiles`;
23. Run `./postconfig.sh` (you don't need to run it with `sudo`) and do what the commands tell you to do;
24. If you are in a laptop, run `./laptopconfig.sh` as well and uncomment the laptop-specific blocks in i3blocks' configuration file (in `~/.config/i3blocks/i3blocks.conf`), and also in i3's configuration file (in `~/.config/i3/config`).
25. Restart i3 by pressing Windows + Shift + R. You don't need to reboot again.
26. **OPTIONAL**: If you have a NVIDIA video card, consider running `drivers.sh` to install them as well; after running it, reboot your computer.

By doing these steps, you'll be good to go! Your programs are ready to be used.
