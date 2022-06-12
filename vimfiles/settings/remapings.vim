" remap syntax is as follows:
" map_mode <whatYouType> <whatYouExecute>

" map modes:
" nnoremap = allows you to map keys in normal mode
" inoremap = allows you to map keys in insert mode
" vnoremap = allows you to map keys in visual mode

" change leader key (default is backslash '\')
"let mapleader = ";"

" map the F5 key to run a Python script inside Vim
" I map F5 to a chain of commands here
" :w saves the file
" <CR> (carriage return) is like pressing the enter key
" !clear runs the external clear screen command
" !python3 % executes the current file with Python
"nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" yank from cursor to the end of line
"nnoremap Y y$

" create a new line and exit
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" toggle spell check on
nnoremap <leader>q :XitOrSpellCheck<CR>

" press F5 for MundoToggle which is the vim undo tree
nnoremap <F5> :MundoToggle<CR>

" press F6 for NERDTreeToggle which is vim file explorer
nnoremap <F6> :NERDTreeToggle<CR>

" press F8 to highlight occurrence of the current word(s)
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" press CTRL + J instead of ESC to switch to NORMAL mode from INSERT mode
inoremap <C-j> <esc>

" press CTRL + J instead of 'i' to switch to INSERT mode from NORMAL mode
" nnoremap <C-j> i

" mapping for vim-smooth-scroll plugin
" smooth_scroll(distance, duration, speed)
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" press SPACE to disable highlight search
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>