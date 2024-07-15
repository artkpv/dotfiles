export NNN_FIFO=/tmp/nnn.fifo
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

#if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#  exec startx
#fi

echo "exec startx - fails from .zprofile. Start manually: exec startx"


