
try
    "colorscheme contrasty
    " colorscheme solarized
    " colorscheme gruvbox
    "colorscheme desert
    " colorscheme onehalflight
    "colorscheme onehalfdark
    colorscheme nord
catch
endtry


CocDisable

set laststatus=0
set foldcolumn=4

au! BufWritePost ~/mydir/notes/* !git add "%";git commit -m "Auto commit of %:t." "%"


function! MyWikiClean() 
    " Clean escape '\' chars inserted by Evernote export.
    %s_\\__gce

    " Clean enclosing of links with '<' and '>' chars.
    %s_\v\<([^\>]+)\>_\1_gce

    %s_\v\!\[\]\((local.*\/([^\)]+))\)(\{wid[^}]*\})?_[\2](\1)_

endfunction

command! PrintDay :norm i99101011111212131314141515161617171818191920202121

