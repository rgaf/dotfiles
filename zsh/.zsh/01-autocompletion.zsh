fpath=($HOME/.zsh/completion $fpath)

autoload -Uz compinit
compinit -u

unsetopt CORRECT_ALL
unsetopt CORRECT

zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+l:|=*'
