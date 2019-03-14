source ~/.profile

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export XDG_CONFIG_HOME="~/.config"

export PSIWARE_INSTANCE_ID="RGAF Psiware Dev"
export PSIWARE_CLIENT_URL="https://psiware.purgator.io"
export PSIWARE_IDENTICON_TMP_DIR="tmp/identicons"
export GRAPHQL_ENDPOINT="https://localhost:5000/graphql"

export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Initialize colors
autoload -U colors
colors
