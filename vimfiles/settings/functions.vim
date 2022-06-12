" this will enable code folding
" use the marker method of folding
" augroup filetype_vim
"     autocmd!
"     autocmd FileType vim setlocal foldmethod=marker
" augroup END

" press enter to highlight occurrence of the current word(s)
" let g:highlighting = 0
" function! Highlighting()
"   if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
"     let g:highlighting = 0
"     return ":silent nohlsearch\<CR>"
"   endif
"   let @/ = '\<'.expand('<cword>').'\>'
"   let g:highlighting = 1
"   return ":silent set hlsearch\<CR>"
" endfunction
" nnoremap <silent> <expr> <CR> Highlighting()
