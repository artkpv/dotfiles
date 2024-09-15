# Author: Artyom K. artkpv.net

if [[ -e ~/mydir/notes/.zsh_secret && ! -e ~/.zsh_secret ]] ; then
  ln -s ~/mydir/notes/.zsh_secret ~/.zsh_secret
fi
if [[ -e ~/.zsh_secret ]] ; then
  . ~/.zsh_secret
fi

PATH=$PATH:$HOME/bin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

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

# Refs https://aur.archlinux.org/packages/zsh-pure-prompt
autoload -U promptinit; promptinit
# turn on git stash status
zstyle :prompt:pure:git:stash show yes
prompt pure

# NNN
export NNN_TRASH=1
export NNN_CONTEXT_COLORS='4321'
export NNN_PLUG='l:-_less -iR $nnn*;o:preview-tabbed;p:rsynccp'
alias n='nnn -xa -P preview-tabbed'


export BAT_THEME=OneHalfLight

##########
# ALIASES 
##########

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

#alias fd='fd -u'
alias g='LANG=en git'
alias info='info --vi-keys'
alias less='less -r'
alias l='ls -haAl --group-directories-first'
alias ls='ls --color=auto'
alias pa='pacman'
alias start=xdg-open
alias vi="LANG=en_US nvim"
alias vim="LANG=en_US nvim"
alias vimrc='nvim ~/.config/nvim/vimrc'
alias zshrc='nvim ~/.zshrc'
function cheat()
{
    curl cheat.sh/$1  | less -r
}
function hl
{
    hledger $* | less -R
}
alias hlui='hledger-ui --watch --theme=terminal'
alias py=python3
alias dstat_my="dstat -cdmn --thermal --top-cpu --top-mem 10"

alias pabrowse_all="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pabrowse="pacman -Qqe | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

alias dk="sudo docker"

alias cb4t='chatblade -c 4t'
alias cb4='chatblade -c 4'
alias cb='chatblade'

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

cdls() {
    cd "$@" && ls;
}

export LEDGER_FILE=$HOME/mydir/accounting/all.ledger

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
export LESSCHARSET=utf-8

export AUR_PAGER='nvim'

export DOTNET_CLI_TELEMETRY_OPTOUT=1




############################################################
#  OTHER
############################################################


function cbr_get_currency() 
{
    # https://gist.github.com/artkpv/3cbff1819846a4eec132be21a1fbd63d
    # Скрипт для получения курса валют на заданную даты из Центробанка 
    if [[ $1 == '-h' || $1 == '--help' ]]; then 
        echo Usage: 'cbr_get_currency [date] [currency]', date in format: DD.MM.YYYY
        return
    fi
    DATE=${1:-$( date +%d/%m/%Y )}
    CURR=${2-USD}
    echo $DATE $CURR $( \
        export LANG=ru_RU.CP1251; \
        curl 'http://www.cbr.ru/scripts/XML_daily.asp?date_req='$DATE -s \
            | grep -Po $CURR'.*?Value>[^<]*' \
            | sed -En -e 's/.*>([0-9,]*)/\1/gp' - \
        )
}

function n-toggle()
{
if ( LANG=en nmcli general status ) | grep -e asleep - ; then nmcli networking on ; else nmcli networking off ; fi
}


export SDCV_PAGER=less
function di()
{
    dict $* | less
    #if [[ $# -ne 0 ]]; then 
    #    sdcv --color $*
    #    echo "Для повтора? [y / N]"
    #    read ans
    #    if [[ "$ans" =~ "1|y|Y" ]]; then
    #        echo "\n\n$*" >> ~/mydir/notes/входящие.md
    #        # sdcv -u "Oxford English Dictionary 2nd Ed. P1" \
    #        #     -u "Oxford English Dictionary 2nd Ed. P2" \
    #        #     $* | head -n10 - >> ~/mydir/notes/входящие.md

    #    fi
    #else
    #    sdcv --color 
    #fi
}

function dark() 
{
    #echo '1\n86' | termite-style > /dev/null
    sed -i -E -e '/set background=dark/s_.*_set background=dark_' -e '/set background=light/s_.*_"set background=light_' ~/.config/nvim/vimrc
    sed -i -E -e '/gtk-theme-name=/s_.*_gtk-theme-name=Adwaita-dark_' ~/.config/gtk-3.0/settings.ini
    sed -i -E -e '/.*syntax-theme.*/s/Light/Dark/' ~/.gitconfig
    sed -i -E -e '/.*BAT_THEME.*/s/Light/Light/' ~/.zshrc
    sed -i -E -e '/.*c.colors.webpage.darkmode.enabled.*/s/.*/c.colors.webpage.darkmode.enabled = True/' ~/.config/qutebrowser/config.py
    sed -i -E -e '/.*light.*/s/light/dark/' ~/.newsboat/config
    sed -i -E -e '/.*light-theme.*/s/light-theme/dark-theme/' ~/.config/alacritty/alacritty.toml
}

function light() 
{
    brightnessctl set 100%
    #echo '1\n69' | termite-style  > /dev/null
    sed -i -E -e '/set background=dark/s_.*_"set background=dark_' -e '/set background=light/s_.*_set background=light_' ~/.config/nvim/vimrc
    sed -i -E -e '/gtk-theme-name=/s_.*_gtk-theme-name=Adwaita_' ~/.config/gtk-3.0/settings.ini
    sed -i -E -e '/.*syntax-theme.*/s/Dark/Light/' ~/.gitconfig
    sed -i -E -e '/.*BAT_THEME.*/s/Light/Light/' ~/.zshrc
    sed -i -E -e '/.*c.colors.webpage.darkmode.enabled.*/s/.*/c.colors.webpage.darkmode.enabled = False/' ~/.config/qutebrowser/config.py
    sed -i -E -e '/.*dark.*/s/dark/light/' ~/.newsboat/config
    sed -i -E -e '/.*dark-theme.*/s/dark-theme/light-theme/' ~/.config/alacritty/alacritty.toml
}

function b-toggle()
{
    if ( brightnessctl| grep 100% ) ; then brightnessctl set 1% ; else brightnessctl set 100%  ; fi  # toggle brightness
}

function script-template()
{
cat <<EOF
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
trap "echo 'error: Script failed: see failed command above'" ERR
EOF
}

function beep()
{
    ffplay -nodisp -autoexit Zip_tone.ogg 2> /dev/null
}

countdown() {
    # https://superuser.com/a/611582
    [[ ! -z "$1" ]] || ( echo Need minutes to count down. ; exit 1 )
    start=$( date +%s )
    echo "$( date ) - started $1 min pomo"
    end="$(( $(date +%s) + $(( $1 * 60 )) ))"
    while [ "$end" -ge $(date +%s) ]; do
        ## Is this more than 24h away?
        days="$(($(($(( $end - $(date +%s) )) * 1 )) / 86400))"
        time="$(( $end - `date +%s` ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
        polybar-msg action ipc send "$(date -u -d "@$time" +%H:%M:%S)" > /dev/null
    done
    minutes="$(( ( $(date +%s) - $start ) * 1 / 60 ))"
    echo "$( date +%Y-%m-%d ) P \n    (pomo)       ${minutes}m"  >> ~/mydir/notes/time/$( date +%Y )-pomo.ledger
    echo "$( date ) - done ${minutes} minutes."
    polybar-msg action ipc send Done > /dev/null
    beep > /dev/null
    beep > /dev/null
    beep > /dev/null
    if [[ $(( $RANDOM % 2 )) == 1 ]]; then
        echo 'Выпал орел. Награда.'
    else 
        echo 'Выпала решка. Награда в другой раз.'
    fi
}

pomo() {
    countdown $1
}

stopwatch() {
    # https://superuser.com/a/611582
    start=$(date +%s)
    while true; do
        days="$(($(( $(date +%s) - $start )) / 86400))"
        time="$(( $(date +%s) - $start ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

myip() {
    curl -m 2 'https://duckduckgo.com/?t=ffab&q=my+ip&ia=answer' -s | grep -o -E 'Your IP address is.*?</a'
}

sshen() {
    ssh -t "$@" "/usr/bin/env OPENAI_API_KEY=$OPENAI_API_KEY HF_TOKEN=$HF_TOKEN GITHUB_TOKEN=$GITHUB_TOKEN WANDB_API_KEY=$WANDB_API_KEY HUGGINGFACEHUB_API_TOKEN=$HUGGINGFACEHUB_API_TOKEN ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY HUGGINGFACEHUB_API_TOKEN=$HUGGINGFACEHUB_API_TOKEN GROQ_API_KEY=$GROQ_API_KEY bash"
}

nordvpn_con() {
    echo use mullvad
    return
    _is_con() { 
        res=$( myip ) 
        echo $res
        [[ "$res" != "" ]] && ( echo $res | grep -v Turkey ) 
    }
    if [[ -e /tmp/nordvpn_success_connections.txt ]] ; then
        for l in $( cat /tmp/nordvpn_success_connections.txt | sort -u | shuf ) ; do   
            nordvpn c $l 
            _is_con && break
        done
    fi
    if ! _is_con ; then echo '' > /tmp/nordvpn_success_connections.txt ; fi
    while ! _is_con ; do nordvpn c Europe ; done         
    nordvpn status | sed -E -n -e 's_Hostname: ([^\.]*).*_\1_p' - >> /tmp/nordvpn_success_connections.txt
}

function excalidraw() {
    if ! docker container ls | grep excalidraw -q ; then 
        docker run --rm -dit --name excalidraw -p 5000:80 excalidraw/excalidraw:latest 
    fi 
    firefox localhost:5000 &
}



# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/art/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias mamba=micromamba
