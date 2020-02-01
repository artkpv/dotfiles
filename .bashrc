#
# Author: Artyom K. w1ld at inbox dot ru
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias lls='ls -haAl --group-directories-first'

PS1='[\u@\h \W]\$ '

alias g=git

alias e=nvim-qt
alias vi=nvim-qt
alias vim=nvim
alias dul='du --human-readable --max-depth=1'

alias start=xdg-open

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.dotnet/bin

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=links
fi

export EDITOR=nvim

alias less='less -r'
export PAGER=less


export MSBuildSDKsPath="/opt/dotnet/sdk/3.0.100/Sdks";
