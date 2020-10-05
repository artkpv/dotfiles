" TODO. Consider - https://github.com/nickspoons/vim-sharpenup

"" Use deoplete.
"call deoplete#enable()

"" Use smartcase.
"call deoplete#custom#option('smart_case', v:true)

"" Use OmniSharp-vim omnifunc 
"call deoplete#custom#source('omni', 'functions', { 'cs':  'OmniSharp#Complete' })
 
"" Set how Deoplete filters omnifunc output.
"call deoplete#custom#var('omni', 'input_patterns', {
    "\ 'cs': '[^. *\t]\.\w*',
    "\})


"call deoplete#custom#option('sources', {
    "\ 'cs': ['omnisharp'],
    "\ })


nmap <buffer> ]g :ALENext<CR>
nmap <buffer> [g :ALEPrevious<CR>

" The following commands are contextual, based on the cursor position.
nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

"" Finds members in the current buffer
nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

"" Navigate up and down by method/property/field
nnoremap <buffer> <Leader>nu :OmniSharpNavigateUp<CR>
nnoremap <buffer> <Leader>nd :OmniSharpNavigateDown<CR>

"" Find all code errors/warnings for the current solution and populate the quickfix window
nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>

"" Show type information automatically when the cursor stops moving
autocmd CursorHold call OmniSharp#TypeLookupWithoutDocumentation()

"" Trigger CursorHold after 1 sec
set updatetime=10



"" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
"" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

"" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
"" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

"" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>


setl foldlevel=2
setl foldnestmax=3

