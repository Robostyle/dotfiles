#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Zsh options.
setopt extended_glob

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

if command -v starship 2>&1 >/dev/null; then
    export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml
    eval "$(starship init zsh)"
fi

if command -v zoxide  2>&1 >/dev/null; then
    eval "$(zoxide init zsh)"
fi

# GO lang
if command -v go 2>&1 >/dev/null; then
    export PATH=$PATH:"$(go env GOPATH)/bin"
fi

# bun and completions
if command -v bun 2>&1 >/dev/null; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

if command -v fastfetch 2>&1 >/dev/null; then
    /usr/bin/fastfetch
fi

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
