-- Declare variable
local opt = vim.opt -- to save typing

-- Set options by using lua api (0=false, 1=true)
-- opt.autowrite = true -- enable auto write
opt.backup = false -- create a backup file
-- opt.clipboard = "unnamedplus", -- allows access to the system clipboard
-- opt.cmdheight = 1 -- more space in command line
opt.colorcolumn = "+1" -- color column at 'textwidth' plus 1
opt.completeopt = { "menu","menuone", "noselect" } -- completion options
opt.conceallevel = 0 -- turns certain characters invisible like `` - 3 hides * markup for bold and italics
-- opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- highlight the current line
opt.expandtab = true -- use spaces instead of tabs (vim-sleuth)
opt.fileencoding = "utf-8" -- set encoding for file
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m" -- format for grep
opt.grepprg = "rg --vimgrep" -- use ripgrep for grep
-- opt.guifont = "monospace:h17" -- font to use
opt.hlsearch = true -- highlight search
opt.ignorecase = true -- ignore case in search patterns
-- opt.inccommand = "nosplit" -- preview incremental substitute
opt.incsearch = true -- incremental search
-- opt.laststatus = 3 -- global statusline
-- opt.list = true -- show some invisible characters (tabs...
opt.mouse = "a" -- allow the mouse to be used
opt.mousemoveevent = true -- allow mouse move events
opt.number = true -- set numbered lines
opt.numberwidth = 4 -- set number column width
opt.pumblend = 10 -- pop up menu blend
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true -- set relative numbered lines
opt.scrolloff = 4 -- amount of lines to keep above and below cursor
-- opt.sessionoptions = {"buffers", "curdir", "tabpages", "winsize"} -- what to save for sessions
-- opt.shiftround = true -- round indent
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation (vim-sleuth)
-- opt.shortmess:append({W = true, I = true, c = true, C = true}) -- append to the short messasge list
opt.showcmd = true -- show command in bottom bar
-- opt.showcmdloc = "statusline" -- show command in bottom bar
opt.showmode = false -- show mode like 'normal', 'insert', etc.
opt.showtabline = 0 -- show tabs - 0 is never, 2 is always
opt.sidescrolloff = 8 -- amount of screen columns to keep left and right
opt.signcolumn = "auto:2" -- always show the sign column
opt.smartcase = true -- override ignorecase if serach pattern contains uppercase
opt.smartindent = true -- indent when going to a new line
opt.smarttab = true -- after insert space or tab to go to next line indent
opt.softtabstop = 4 -- tab key will insert spaces or tabs
opt.splitbelow = true -- force horizontal splits to below of current window
-- opt.splitkeep = "screen" -- keep window split when opening new file
opt.splitright = true -- force vertical splits to go right of current window
opt.swapfile = false -- create a swapfile
opt.tabstop = 4 -- insert X spaces for a tab - width of tab
opt.termguicolors = true -- set terminal colors
opt.textwidth = 100 -- set line width
opt.timeoutlen = 100 -- time to wait for mapped sequence default=300
opt.ttimeoutlen = 50 -- time to wait for key code sequence to complete
opt.undofile = true -- create a undo file for persistent undo
-- opt.undolevels = 1000 -- maximum number of changes that can be undone
opt.updatetime = 300 -- faster completion save swap file and trigger CursorHold
-- opt.virtualedit = "block" -- allow cursor to move where there is no characters
opt.wildmode = "longest:full,full" -- command-line completion mode
-- opt.winminwidth = 5 -- minimum width of a window
opt.wrap = true -- allow lines to wrap
opt.wrapscan = true -- allow search to cycle to top once it hits bottom
opt.writebackup = false -- create a writebackup file
opt.shortmess:append("c") -- append to the short messasge list

-- Set options by passing vimscript commands
vim.cmd("set whichwrap+=<,>,[,],h,l") -- allows specific characters to move to new line when at end/start

-- Set options by passing vimscript commands - another way to write it
vim.cmd([[set iskeyword+=-]]) -- treat 'some-word' as one word

-- Default cursor settings
-- vim.cmd [[set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]

-- Change the default cursor settings
vim.cmd([[set guicursor=n-v-c-sm:block,i-ci-ve-r-cr-o:hor20,a:blinkon100]])

-- Speed up loading lua modles to improve startup time
vim.loader.enable()
