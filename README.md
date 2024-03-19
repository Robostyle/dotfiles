# Dependencies

For **zsh** the following tools/utilities need to be installed.

Linux distro independent:

## Starship

The minimal, blazing-fast, and infinitely customizable prompt for any shell!

`curl -sS https://starship.rs/install.sh | sh -s --bin-dir ~/.localbin`

## eza

A modern, maintained replacement for ls.

`wget -qc https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz -C ~/.local/bin`

## fzf

A general-purpose command-line fuzzy finder.

`wget -qc https://github.com/junegunn/fzf/releases/latest/download/fzf-0.46.1-linux_amd64.tar.gz -O - | tar xz -C ~/.local/bin`

## Zoxide

zoxide is a smarter cd command, inspired by z and autojump.

`curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash`

## Yazi

Blazing fast terminal file manager written in Rust, based on async I/O.

```
wget -qO- https://github.com/sxyazi/yazi/releases/download/v0.2.3/yazi-x86_64-unknown-linux-gnu.zip | bsdtar -xf- --acls -C /tmp && mv /tmp/yazi-x86_64-unknown-linux-gnu/yazi ~/.local/bin && chmod +x ~/.local/bin/yazi
```


# System

I run Arch Linux (or on some machines Manjaro). The list of minimal packages I have installed as a base system:

    * chezmoi
    * eza
    * lazygit
    * neovim
    * ranger
    * ripgrep
    * tig
    * tmux
    * yay
    * zsh

and graphical applications:

    * alacritty
    * firefox
    * fuzzel
    * greetd-tuigreet
    * grim-blast
    * hyperland
    * hyprpaper
    * imagemagick
    * mako
    * polkit-kde-agent
    * rofi
    * swayidle
    * swaylock-effects-git
    * thunar
    * waybar
    * wireplumber
    * wl-clipboard
    * wlogout
    * xdg-desktop-portal-hyprland

Fonts I use:

    * ttf-jetbrains-mono-nerd

## Install

```
pacman -S chezmoi eza lazygit neovim ranger ripgrep tig tmux yay zsh \
    alacritty firefox fuzzel greetd-tuigreet grim-blast hyperland \
    hyprpaper imagemagick mako polkit-kde-agent rofi swayidle \
    swaylock-effects-git thunar waybar wireplumber wl-clipboard \
    wlogout xdg-desktop-portal-hyprland ttf-jetbrains-mono-nerd
```

> [!IMPORTANT]
>
> Some other utilities I use

```shell
pacman -S glow
```


# Configurations

## Hyperland

My setup for Hyperland is pretty standard, but I changed some of the colors and added my personal key bindings. The configuration is
split in separate files for GUI config, key bindings and window rules.

## neovim

I use [LazyVim](https://www.lazyvim.org/) as a base configuration for my neovim setup. I really like it and saves me a ton of time configuring things myself.
Out of the box it is pretty well configured already, but defaults are easy to change. For example: I hate auto pairs, so this is
disabled. For git I use the excellent [neogit](https://github.com/NeogitOrg/neogit) plugin. For automatic folding I use [ufo](https://github.com/kevinhwang91/nvim-ufo).
The rest is just keybinding and options I prefer and the color scheme [cattpuccin](https://github.com/catppuccin/nvim).


