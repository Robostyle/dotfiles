# vim:expandtab:ts=4:sw=4

if [ -f "/usr/bin/neofetch" ]; then
    cat /tmp/.nf 2> /dev/null
    setsid neofetch >| /tmp/.nf
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/git",                  from:oh-my-zsh
zplug "plugins/command-not-found",    from:oh-my-zsh
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "rupa/z",                       from:github

zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-syntax-highlighting

if ! zplug check; then
    zplug install
fi

zplug load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

typeset -gA keys=(
    Up                   '^[[A'
    Down                 '^[[B'
    Right                '^[[C'
    Left                 '^[[D'
    Home                 '^[[1~'
    End                  '^[[4~'
    Insert               '^[[2~'
    Delete               '^[[3~'
    PageUp               '^[[5~'
    PageDown             '^[[6~'
    Backspace            '^?'

    Shift+Up             '^[[1;2A'
    Shift+Down           '^[[1;2B'
    Shift+Right          '^[[1;2C'
    Shift+Left           '^[[1;2D'
    Shift+End            '^[[1;2F'
    Shift+Home           '^[[1;2H'
    Shift+Insert         '^[[2;2~'
    Shift+Delete         '^[[3;2~'
    Shift+PageUp         '^[[5;2~'
    Shift+PageDown       '^[[6;2~'
    Shift+Backspace      '^?'
    Shift+Tab            '^[[Z'

    Ctrl+Up              '^[[1;5A'
    Ctrl+Down            '^[[1;5B'
    Ctrl+Right           '^[[1;5C'
    Ctrl+Left            '^[[1;5D'
    Ctrl+Home            '^[[1;5H'
    Ctrl+End             '^[[1;5F'
    Ctrl+Insert          '^[[2;5~'
    Ctrl+Delete          '^[[3;5~'
    Ctrl+PageUp          '^[[5;5~'
    Ctrl+PageDown        '^[[6;5~'
    Ctrl+Backspace       '^H'
  )

bindkey -- "${keys[Home]}"            .beginning-of-line
bindkey -- "${keys[End]}"             .end-of-line
bindkey -- "${keys[Insert]}"          .overwrite-mode
bindkey -- "${keys[Backspace]}"       .backward-delete-char
bindkey -- "${keys[Delete]}"          .delete-char
bindkey -- "${keys[Up]}"              .up-line-or-history
bindkey -- "${keys[Down]}"            .down-line-or-history
# bindkey -- "${keys[Left]}"            .backward-char
# bindkey -- "${keys[Right]}"           .forward-char
bindkey -- "${keys[PageUp]}"          .beginning-of-buffer-or-history
bindkey -- "${keys[PageDown]}"        .end-of-buffer-or-history
bindkey -- "${keys[Ctrl+Left]}"       .backward-word
bindkey -- "${keys[Ctrl+Right]}"      .forward-word

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export SUDO_EDITOR=/usr/bin/nvim

if [ -f $HOME/.zsh_aliases ]
then
    . $HOME/.zsh_aliases
fi

# NVM nodjs manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f $HOME/.tmux/plugins/tpm/bin/install_plugins ]; then
  $HOME/.tmux/plugins/tpm/bin/install_plugins > /dev/null
  $HOME/.tmux/plugins/tpm/bin/update_plugins all > /dev/null
fi