" Antelope ftdetect file
" Filename:     antelope.vim
" Maintainer:   UC San Diego Array Network Facility
" URL:          https://github.com/UCSD-ANF/vim-antelope
" Last Change:
" Version:

" detect Antelope filetypes
au BufRead,BufNewFile *.pf               set filetype=antelope
au BufRead,BufNewFile *.xpl              set filetype=perl
au BufRead,BufNewFile *.xpls             set filetype=perl
au BufRead,BufNewFile *.xpy              set filetype=python
au BufRead,BufNewFile *.xpys             set filetype=python
