
" Consider: 
" xoria256, zazen, yeller, dzo, sialoquent, dracula, zenburn,
" alduin, baycomb
" mono colors: cake, candycode
colorscheme alduin
" colorscheme colorsbox-material
set laststatus=0
set foldcolumn=4

au! BufWritePost ~/mydir/notes/* !git add "%";git commit -m "Auto commit of %:t." "%"

