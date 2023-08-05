if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

export NNN_FIFO=/tmp/nnn.fifo

