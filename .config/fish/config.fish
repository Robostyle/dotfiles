source /usr/share/cachyos-fish-config/cachyos-config.fish

alias vi="nvim"
alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing

set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim

__starship
__zoxide
