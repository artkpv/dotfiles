# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Author: Artyom K. w1ld at inbox dot ru

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ -e ~/mydir/notes/.zsh_secret && ! -e ~/.zsh_secret ]] ; then
  ln -s ~/mydir/notes/.zsh_secret ~/.zsh_secret
fi
if [[ -e ~/.zsh_secret ]] ; then
  . ~/.zsh_secret
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="robbyrussell"

# Set fzf installation directory path
#export FZF_BASE=$( dirname `which fzf ` )

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
    fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


alias ls='ls --color=auto'
alias lls='ls -haAl --group-directories-first'

alias less='less -r'

alias g=git

alias info='info --vi-keys'

alias vi="LANG=en_US nvim"
alias vim="LANG=en_US nvim"
alias qvim="LANG=en_US nvim-qt"
alias vimrc='nvim ~/.config/nvim/vimrc'

alias start=xdg-open
alias spa='sudo pacman'
alias pa='pacman'

alias tm='tmux attach'

function hl
{
    hledger $* | less -R
}
alias hlui='hledger-ui --watch --theme=terminal'

export LEDGER_FILE=$HOME/mydir/accounting/all.ledger

PATH=$PATH:$HOME/bin

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=links
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL=nvim
export PAGER='less -R'

export AUR_PAGER='nvim'

# alias transw='trans -t en:ru+en -no-ansi'
function transw () {
    ( trans -from en -no-ansi -to ru -brief $@; trans -from en -no-ansi -dictionary -show-original n $@ ) | tee | xclip
}

export DOTNET_CLI_TELEMETRY_OPTOUT=1


######
# nnn 
######
export NNN_TRASH=1
export NNN_CONTEXT_COLORS='4321'
export NNN_PLUG='p:-_less -iR $nnn*;o:preview-tabbed'

alias nnn='nnn -xa -P preview-tabbed'


#### 
# DotNet tab completion
####

# See https://docs.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete
# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet


# Enable bash autocompletions 
autoload -U +X bashcompinit && bashcompinit

TIMELOG=~/mydir/notes/time/2020.timeclock
alias вна="echo н `date '+%Y-%m-%d %H:%M'` \$* >>$TIMELOG"     
alias вза="echo з `date '+%Y-%m-%d %H:%M'` >>$TIMELOG"

function dotnet-new-pr
{
dotnet new console
mv Program.cs pr.cs
dotnet new sln
dotnet sln add *.csproj
}


alias py=python3

# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias vpn="sudo vpnstart.sh"

function onwakeup 
{
    bluetoothctl connect 00:1F:20:95:E8:F7
    redshift -x
}

alias pabrowse_all="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pabrowse="pacman -Qqe | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

alias dkr="sudo docker"

export PATH=$PATH:/home/art/bin

AZCOMPLETION="$HOME/lib/azure-cli/az.completion"
if [[ -e $AZCOMPLETION ]] ; then
	source $AZCOMPLETION 
fi

function set_background
{
    img="$HOME/Downloads/pictures/image.png"
    curl bing.com -skL | grep -E 'https://www.bing.com/th[^"]*' -o | xargs curl -s -o$img 
    feh --bg-scale "$img" 
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/mydir/ref/dotfiles/p10k.zsh.
[[ ! -f ~/mydir/ref/dotfiles/p10k.zsh ]] || source ~/mydir/ref/dotfiles/p10k.zsh


function cbr_get_currency() 
{
    # https://gist.github.com/artkpv/3cbff1819846a4eec132be21a1fbd63d
    # Скрипт для получения курса валют на заданную даты из Центробанка 
    DATE=$1  # 02/03/2002
    CURR=${2-USD}
    export LANG=ru_RU.CP1251; curl 'http://www.cbr.ru/scripts/XML_daily.asp?date_req='$DATE -s |  grep -Po $CURR'.*?Value>[^<]*' | sed -En -e 's/.*>([0-9,]*)/\1/gp' -
}

function n-toggle()
{
if ( LANG=en nmcli general status ) | grep -e asleep - ; then nmcli networking on ; else nmcli networking off ; fi
}

function b-toggle()
{
if ( brightnessctl| grep 100% ) ; then brightnessctl set 1% ; else brightnessctl set 100%  ; fi  # toggle brightness
}

export SDCV_PAGER=less
function di()
{
    if [[ $# -ne 0 ]]; then 
        sdcv --color $*
        echo "Для повтора? [y / N]"
        read ans
        if [[ "$ans" =~ "1|y|Y" ]]; then
            echo "\n\n$*" >> ~/mydir/notes/входящие.md
            # sdcv -u "Oxford English Dictionary 2nd Ed. P1" \
            #     -u "Oxford English Dictionary 2nd Ed. P2" \
            #     $* | head -n10 - >> ~/mydir/notes/входящие.md

        fi
    else
        sdcv --color 
    fi
}
