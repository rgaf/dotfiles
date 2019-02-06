export __GIT_PROMPT_DIR="~/Repos/zsh-git-prompt"
export GIT_PROMPT_EXECUTABLE="haskell"

autoload -Uz colors && colors

autoload -Uz add-zsh-hook

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

# preexec_update_git_vars {{{
function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}
# }}}

# precmd_update_git_vars {{{
function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ ! -n "$ZSH_THEME_GIT_PROMPT_CACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}
# }}}

# chpwd_update_git_vars {{{
function chpwd_update_git_vars() {
    update_current_git_vars
}
# }}}

# update_current_git_vars {{{
function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    _GIT_STATUS=`git status --porcelain --branch &> /dev/null | gitstatus`
    __CURRENT_GIT_STATUS=("${(@s: :)_GIT_STATUS}")

    GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
    GIT_AHEAD=$__CURRENT_GIT_STATUS[2]
    GIT_BEHIND=$__CURRENT_GIT_STATUS[3]
    GIT_STAGED=$__CURRENT_GIT_STATUS[4]
    GIT_CONFLICTS=$__CURRENT_GIT_STATUS[5]
    GIT_CHANGED=$__CURRENT_GIT_STATUS[6]
    GIT_UNTRACKED=$__CURRENT_GIT_STATUS[7]
}
# }}}

# git_super_status {{{
git_super_status() {
    precmd_update_git_vars

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$GIT_BRANCH"

        if [ "$GIT_BEHIND" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND"
        fi

        if [ "$GIT_AHEAD" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD"
        fi

        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"

        if [ "$GIT_STAGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED"
        fi

        if [ "$GIT_CONFLICTS" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS"
        fi

        if [ "$GIT_CHANGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED"
        fi

        if [ "$GIT_UNTRACKED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
        fi

        if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
        fi

        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"

        echo "${GIT_COLOR}$STATUS${RESET_COLOR}"
    fi
}
# }}}

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_STAGED="%{⋄%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{✔%G%}"

USER_COLOR="%{$fg[blue]%}"
HOST_COLOR="%{$fg[blue]%}"
PWD_COLOR="%{$fg[red]%}"
GIT_COLOR="%{$fg[green]%}"
RESET_COLOR="%{$reset_color%}"

#PROMPT="%{%F{blue}%}%n@%m %{%F{red}%}%~%{%F{reset}%} $(git_super_status)%{%F{reset}%}$ "
PROMPT="${USER_COLOR}%n@%m${RESET_COLOR}${PWD_COLOR}[%3~]${RESET_COLOR}$(git_super_status) ${USER_COLOR}%(w.✝.λ)${RESET_COLOR} "
