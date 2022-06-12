" clear status line when vimrc is reloaded.
"set statusline=

" status line left side.
"set statusline+=\ %F\ %M\ %Y\ %R
" %F = display full path of file
" %M = display modified flag i.e. show if file is not save
" %Y = display type of buffer
" %R = display read-only flag

" use a divider to separate the left side from the right side.
"set statusline+=%=

" status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" %b = display ascii/unicode character under cursor
" 0x%B = show the hexadecimal character under cursor
" %l = display the row number
" %c = display the column number
" %p%% = show the cursor percentage from the top of the file

" show the status on the second to last line.
"set laststatus=2

" using vim-airline for status bar and changing Y output
"let g:airline_section_y = 'W %{winnr()}'