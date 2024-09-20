# Author: Artyom K. artkpv.net

PATH=$PATH:$HOME/bin:$HOME/.local/bin

# Avoid failing if no oh-my-zsh:
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/ohmyz.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/ohmyz.sh"


# Prompt:
fpath+=($ZDOTDIR/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes # turn on git stash status
prompt pure

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history


[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh


export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1
export NNN_CONTEXT_COLORS='4321'
export NNN_PLUG='l:-_less -iR $nnn*;o:preview-tabbed;p:rsynccp'

export BAT_THEME=OneHalfLight

export LESSCHARSET=utf-8

export AUR_PAGER='nvim'

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export SDCV_PAGER=less
