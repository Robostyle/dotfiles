# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -l is_darwin "false"
set -l is_linux  "false"
set -l is_arch   "false"

switch (uname)
    case Darwin
        set is_darwin "true"
    case Linux
        set is_linux  "true"

	if test -f /etc/os-release; and grep -q -i "arch" /etc/os-release
		set is_arch "true"
	end
end

if test $is_arch = "true"
	echo "Is arch Linux"
end
if test $is_darwin = "true"
	echo "Is OSX"
end

# Initialize Homebrew environment dynamically (macOS only)
if test $is_darwin = "true"
    set -l brew_path /opt/homebrew/bin/brew
    if not test -f $brew_path
        set brew_path /usr/local/bin/brew
    end

    if test -f $brew_path
        $brew_path shellenv | source
    end
end

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

if status is-interactive
    fish_config theme choose kanagawa
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

## Set values
## Run fastfetch as welcome message
function fish_greeting
    if type -q fastfetch
		fastfetch
    end
end

## Useful aliases
# Replace ls with eza
if type -q eza
	alias ls='eza --color=always --group-directories-first --icons=auto' # preferred listing
	alias la='eza -a --color=always --group-directories-first --icons=auto' # all files and dirs
	alias ll='eza -l --color=always --group-directories-first --icons=auto' # long format
	alias lt='eza -aT --color=always --group-directories-first --icons=auto' # tree listing
	alias l.="eza -a | grep -e '^\.'" # show only dotfiles
else
	echo "No eza installed"
end

# Common use
if test $is_arch = "true"
	alias fixpacman="sudo rm /var/lib/pacman/db.lck"
	alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
	alias update='sudo pacman -Syu'
	alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
	# Recent installed packages
	alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
	# Cleanup orphaned packages
	alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
end

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info

alias vi="nvim"
alias vim="nvim"
alias lg='lazygit'

set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR nvim
set -gx VISUAL nvim

__starship
__zoxide
__niri

if test -e ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end
