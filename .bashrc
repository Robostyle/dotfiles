#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi="nvim"
alias zi="zoxide"

# Eza
if command -v eza &>/dev/null; then
  alias ls='eza --color=always --group-directories-first --icons'
  alias ll='eza -la --icons --octal-permissions --group-directories-first'
  alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
  alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons'
  alias la='eza --long --all --group --group-directories-first'
  alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'

  alias lS='eza -1 --color=always --group-directories-first --icons'
  alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
  alias l.="eza -a | grep -E '^\.'"
fi

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '....'.='cd ../../../..'
alias '.....'.='cd ../../../../..'

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
