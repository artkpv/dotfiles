" Temporary disable tabs. See https://github.com/equalsraf/neovim-qt/issues/574#issuecomment-522826858
" Use Vim Styling for Tabs, Qt Disabled
if exists(':GuiTabline')
	GuiTabline 0
endif

set guifont=Source\ Code\ Pro:h10


" Disable Windows popup to make correct formatting. See https://github.com/neovim/neovim/issues/9026
GuiPopupmenu 0

