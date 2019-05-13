source ~/.profile

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export XDG_CONFIG_HOME="~/.config"

export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Initialize colors
autoload -U colors
colors
