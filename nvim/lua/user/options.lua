-- Nvim Options - create a lua table for our options
local options = {
    backup = false, -- create a backup file
    --[[ clipboard = "unnamedplus",             -- allows access to the system clipboard ]]
    cmdheight = 2, -- more space in command line
    completeopt = {"menuone", "noselect"}, -- completion options
    conceallevel = 0, -- turns certain characters invisible like ``
    cursorline = true, -- highlight the current line
    directory = ".,$TMP,$TEMP,/var/tmp,/tmp", -- where to store swap files
    expandtab = true, -- convert tab to spaces
    fileencoding = "utf-8", -- set encoding for file
    guifont = "monospace:h17", -- font to use
    hlsearch = false, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    incsearch = true, -- show search matches as you type
    mouse = "a", -- allow the mouse to be used
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width
    pumheight = 10, -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    scrolloff = 8, -- amount of lines to keep above and below cursor
    -- shell = "C:\\Program Files\\PowerShell\7\\pwsh.exe", -- set shell to pwsh
    -- shellcmdflag = "-NoLogo -NoProfile -Command", -- flags for shell
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    showmode = false, -- show mode like 'normal', 'insert', etc.
    showtabline = 0, -- show tabs - 0 is never, 2 is always
    sidescrolloff = 8, -- amount of screen columns to keep left and right
    signcolumn = "yes", -- always show the sign column
    smartcase = true, -- override ignorecase if serach pattern contains uppercase
    smartindent = true, -- indent when going to a new line
    splitbelow = true, -- force horizontal splits to below of current window
    splitright = true, -- force vertical splits to go right of current window
    swapfile = false, -- create a swapfile
    tabstop = 2, -- insert X spaces for a tab
    termguicolors = true, -- set terminal colors
    timeoutlen = 100, -- time to wait for mapped sequence
    ttimeoutlen = 50, -- time to wait for key code sequence to complete
    undofile = true, -- create a undo file for persistent undo
    updatetime = 300, -- faster completion
    wrap = true, -- allow lines to wrap
    wrapscan = true, -- allow search to cycle to top once it hits bottom
    writebackup = false -- create a writebackup file
}

-- Set options by using lua api
vim.opt.shortmess:append "c" -- append to the short messasge list

-- Set options by passing vimscript commands
vim.cmd "set whichwrap+=<,>,[,],h,l" -- allows specific characters to move to new line when at end/start

vim.cmd [[set iskeyword+=-]] -- treat 'some-word' as one word

-- Default cursor settings
-- vim.cmd [[set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]]

-- Change the default cursor settings
vim.cmd [[set guicursor=n-v-c-sm:block,i-ci-ve-r-cr-o:hor20,a:blinkon100]]

-- Go through the lua table as a key value pair
for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Set all vim.notify to the plugin one
vim.notify = require("notify")

-- Change default shell to pwsh.exe
vim.cmd([[
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"'
let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
set shellquote= shellxquote=
]])

-- vim.opt.shell = "pwsh"
-- vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
-- vim.opt.shellcmdflag = "-NoLogo -NoProfile -NonInteractive -Executionpolicy RemoteSigned -Command $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
-- vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.opt.shellxquote = ""
-- vim.opt.shellquote = ""
-- vim.cmd([[
--     set shell=pwsh.exe
--     set shellcmdflag=-command
--     set shellquote=\"
--     set shellxquote=
-- ]])
-- vim.cmd("set shell=pwsh.exe")
-- vim.cmd("set shellcmdflag=\\ -nologo\\ -noprofile\\ -noninteractive\\ -command")
-- vim.cmd [[set shell=C:/Program Files/PowerShell/7/pwsh.exe]]
-- vim.cmd [[set shellcmdflag=\ -ExecutionPolicy\ RemoteSigned\ -NoProfile\ -NoLogo\ -NonInteractive\ -Command]]

-- Map `-` as the Easymotion key
-- vim.cmd [[map - <Plug>(easymotion-prefix)]]
-- vim.cmd [[let g:EasyMotion_disable_two_key_combo = 1]]

-- Set tab and space characters -> moved to indentline.lua
-- vim.cmd [[set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·]]
-- vim.cmd [[set list]]
