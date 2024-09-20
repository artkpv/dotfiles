# Author: Artyom K. artkpv.net

PATH=$PATH:$HOME/bin:$HOME/.local/bin

# Avoid failing if no oh-my-zsh:
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/ohmyz.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/ohmyz.sh"


# Prompt:
fpath+=($ZDOTDIR/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes # turn on git stash status
prompt pure

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh


export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1
export NNN_CONTEXT_COLORS='4321'
export NNN_PLUG='l:-_less -iR $nnn*;o:preview-tabbed;p:rsynccp'

export BAT_THEME=OneHalfLight

export LESSCHARSET=utf-8

export AUR_PAGER='nvim'

export DOTNET_CLI_TELEMETRY_OPTOUT=1




############################################################
#  OTHER
############################################################


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
