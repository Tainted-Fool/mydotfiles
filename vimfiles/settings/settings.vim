" disable beep sound from vim
set visualbell
set t_vb=

" set UTF encoding
set encoding=utf-8

" set buffer to not disappear 
set hidden

" enable spell checking
"set spell 
set spelllang=en_us

" auto enable spell check with vim-SpellCheck
let g:SpellCheck_OnNospell = function('SpellCheck#AutoEnableSpell')

" do not use vi - legacy mode
set nocompatible

" more powerful backspacing
set backspace=indent,eol,start

" syntax highlight
syntax on

" highlight all search results
set hlsearch

" show incremental search results as you type
set incsearch

" display line number
set number

" display relative numbers i.e. current line starts at 0
set relativenumber

" do case insensitive search
set ignorecase smartcase

" set search to cycle to top once it hits the bottom
set wrapscan

" set ripgrep as search
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" allows you to copy/paste text from external program i.e. clipboard
set clipboard=unnamed

" increment/decrement alphanumeric values with CTRL + A and CTRL + X
set nrformats+=alpha

" save views of buffers
"autocmd BufWinLeave *.txt mkview
"autocmd BufWinEnter *.txt loadview

" set auto indenting
set ai

" allow words to wrap
set wrap

" enable file type detection
filetype plugin on

" load indent file
filetype indent on

" show the command you type last
set showcmd

" show the mode you are on the last line
set showmode

" set the amount of commands to save in history default is 20
set history=1000

" enable auto-completion menu after pressing tab
set wildmenu

" make the menu behave similar to bash
set wildmode=list:longest,longest:full

" enable rainbow brackets
let g:rainbow_active = 1

" set default mapping to CamelCaseMotion plugin
let g:camelcasemotion_key = '<leader>'

" set default vimwiki syntax
let g:vimwiki_list = [{'path': '$HOME/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" onehalfdark theme
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }

" set true colors for theme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" enable persistent undo so that undo history persist across vim sessions
" Linux default = ~/.vim/undo; Windows default = $HOME/vimfiles/undo
if version >= 703
    set undodir=$HOME/vimfiles/undo
    set undofile
    set undoreload=1000
endif

" set python environment variable from anaconda
" if has('nvim') && !empty($CONDA_PREFIX)
"   let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
" endif
