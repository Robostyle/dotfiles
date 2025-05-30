source /usr/share/cachyos-fish-config/cachyos-config.fish

set -g fish_key_bindings fish_vi_key_bindings

alias vi="nvim"
alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing

set -gx EDITOR /usr/bin/nvim

__starship
__zoxide
