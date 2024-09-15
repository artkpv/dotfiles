
# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

[[ ! -f "$ZSH/oh-my-zsh.sh" ]] && echo "No oh-my-zsh found at $ZSH/oh-my-zsh.sh" && return

plugins=(
    git
    vi-mode
    fzf
    docker
)
source $ZSH/oh-my-zsh.sh


#########
# PLUGINS
#########

source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh

export FZF_DEFAULT_OPTS="--height=80% --border --layout=reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="fd"
