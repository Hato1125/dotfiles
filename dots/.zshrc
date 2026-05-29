export PATH="$HOME/.local/bin:$PATH"

export MOZ_LEGACY_PROFILES=0
export EDITOR="nvim"
export BROWSER="zen-browser"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

[ -f $XDG_CONFIG_HOME/env ] && source $XDG_CONFIG_HOME/env

alias ls='ls --color=auto'
alias grep='grep --color=auto'

autoload -Uz colors
colors

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

setopt AUTO_MENU
unsetopt BEEP

eval "$(starship init zsh)"
