# Author: Artyom K. artkpv.net

PATH=$PATH:$HOME/bin:$HOME/.local/bin

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


# vi mode
bindkey -v
export KEYTIMEOUT=1

cursor_mode() {
    # Change cursor shape for different vi modes.
    function zle-keymap-select () {
        case $KEYMAP in
            vicmd) echo -ne '\e[1 q';;      # block
            viins|main) echo -ne '\e[5 q';; # beam
        esac
    }
    zle -N zle-keymap-select
    zle-line-init() {
        zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
}
cursor_mode


completion() {
    # Basic auto/tab complete:
    autoload -U compinit
    zstyle ':completion:*' menu select
    zmodload zsh/complist
    compinit
    _comp_options+=(globdots)		# Include hidden files.


    # Use vim keys in tab complete menu:
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    bindkey -v '^?' backward-delete-char
}
completion

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete


vi_text_objects_and_surround() {
    autoload -Uz select-bracketed select-quoted
    zle -N select-quoted
    zle -N select-bracketed
    for km in viopp visual; do
      bindkey -M $km -- '-' vi-up-line-or-history
      for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km $c select-quoted
      done
      for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
      done
    done


    autoload -Uz surround
    zle -N delete-surround surround
    zle -N add-surround surround
    zle -N change-surround surround
    bindkey -M vicmd cs change-surround
    bindkey -M vicmd ds delete-surround
    bindkey -M vicmd ys add-surround
    bindkey -M visual S add-surround
}
vi_text_objects_and_surround


export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1
export NNN_CONTEXT_COLORS='4321'
export NNN_PLUG='l:-_less -iR $nnn*;o:preview-tabbed;p:rsynccp'

export BAT_THEME=OneHalfLight

export LESSCHARSET=utf-8

export AUR_PAGER='nvim'

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export SDCV_PAGER=less

export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"



function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


export _ZO_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zoxide"
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
if [[ -e /usr/share/fzf ]] ; then 
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
