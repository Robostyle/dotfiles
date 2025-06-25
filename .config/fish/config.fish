## Source from conf.d before our fish config
source ~/.config/fish/conf.d/done.fish # https://github.com/franciscolourenco/done/blob/master/conf.d/done.fish

# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
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
    fastfetch
end

## Useful aliases
# Replace ls with eza
alias ls='eza --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles

# Common use
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias update='sudo pacman -Syu'

# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

alias vi="nvim"
alias lg='lazygit'

set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim

__starship
__zoxide

if test -e ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end
