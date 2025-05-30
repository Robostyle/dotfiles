# My dotfiles managed with `yadm`

These are my personal opinionated dotfiles.

I created this repo to help me backup my config files and to easily deploy them on a new machine. I use
[yadm](https://yadm.io/) to manage these files.

## Core system info

- OS: [Arch Linux](https://archlinux.org/).
- WM: [hyprland](https://hyprland.org/)
- bash: [zsh](https://zsh.org/)
- Terminal Emulator: [Ghostty](https://ghostty.org/)
- Panel: [hyprpanel](https://hyprpanel.com/)
- Text Editor: [neovim](https://neovim.io/)
- App Launcher: [fuzzel](https://codeberg.org/dnkl/fuzzel)

## Base system install

> [!NOTE]
> The names of the packages are from the AUR and Arch Repos; adapt them to your system. Most of the packages are available on other distros official repos (most of the time out-of-date).
>
> To install CLI/TUI specific packages in non-arch based distros, I recommend to use [homebrew](https://brew.sh/).
>
> In the guide, I will be using [Paru](https://github.com/morganamilo/paru) as the AUR helper. Be sure to install it or change the commands to your preferred one. Note, `pacman` will be used to install official Arch packages. A separate section will use Paru to install packages from the AUR.

[!WARNING]

> The installation guide is under construction, try it at your own risk!

### System

```bash
sudo pacman -Sy --needed hyprland hyprlock hypridle hyprpaper hyprpicker xdg-desktop-portal-hyprland hyprsunset hyprpolkitagent hyprcursor base-devel uwsm playerctl
paru -Sy walker-bin clipse
```

### CLI/TUI

```bash
sudo pacman -Sy fastfetch git fzf jq eza fd zsh starship ripgrep bat yazi which zellij yadm less btop zoxide
```

### Audio Services

Install the dependencies:

```bash
sudo pacman -Sy pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils
```

Now enable `pipewire` and `wireplumber` systemd Services:

```bash
systemctl --user enable --now pipewire wireplumber
```

### Fonts

```bash
sudo pacman -Sy noto-fonts noto-fonts-emoji
paru -Sy ttf-maple
```

After installing, refresh the font cache:

```bash
fc-cache -fv
```

### GUI Apps

```bash
sudo pacman -Sy ghostty
```

Optional Gnome apps:

```bash
sudo pacman -Sy nautilus boabab gnome-characters gnome-disk-utility gnome-system-monitor gvfs-smb
```

```bash
paru -Sy brave-bin
```

## Starting desktop

We use uwsm to manage starting and stopping Hyprland.

```bash
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hypridle.service
systemctl --user enable --now hyprsunset.service
systemctl --user enable --now hyprpolkitagent.service
```

## TODO

- check out hyprland groups
- check my config against latest hyprland sample config
