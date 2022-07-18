-- Nvim Options - create a lua table for our options
local options = {
    backup = false,                        -- create a backup file
    clipboard = "unnamedplus",             -- allows access to the system clipboard
    cmdheight = 2,                         -- more space in command line
    completeopt = {"menuone", "noselect"}, -- completion options
    conceallevel = 0,                      -- turns certain characters invisible like ``
    cursorline = true,                     -- highlight the current line
    expandtab = true,                      -- convert tab to spaces
    fileencoding = "utf-8",                -- set encoding for file
    guifont = "monospace:h17",             -- font to use
    ignorecase = true,                     -- ignore case in search patterns
    mouse = "a",                           -- allow the mouse to be used
    number = true,                         -- set numbered lines
    numberwidth = 4,                       -- set number column width
    pumheight = 10,                        -- pop up menu height
    relativenumber = true,                 -- set relative numbered lines
    scrolloff = 8,                         -- amount of lines to keep above and below cursor
    shiftwidth = 2,                        -- the number of spaces inserted for each indentation
    showmode = false,                      -- show mode like 'normal', 'insert', etc.
    showtabline = 2,                       -- always show tabs
    sidescrolloff = 8,                     -- amount of screen columns to keep left and right
    signcolumn = "yes",                    -- always show the sign column
    smartcase = true,                      -- override ignorecase if serach pattern contains uppercase
    smartindent = true,                    -- indent when going to a new line
    splitbelow = true,                     -- force horizontal splits to below of current window
    splitright = true,                     -- force vertical splits to go right of current window
    swapfile = false,                      -- create a swapfile
    tabstop = 2,                           -- insert 2 spaces for a tab
    termguicolors = true,                  -- set terminal colors
    timeoutlen = 1000,                     -- time to wait for mapped sequence
    ttimeoutlen = 50,                      -- time to wait for key code sequence to complete
    undofile = true,                       -- create a undo file for persistent undo
    updatetime = 300,                      -- faster completion
    wrap = true,                           -- allow lines to wrap
    wrapscan = true,                       -- allow search to cycle to top once it hits bottom
    writebackup = false,                   -- create a writebackup file
}

-- Set options by using lua api
vim.opt.shortmess:append "c"               -- append to the short messasge list

-- Set options by passing vimscript commands
vim.cmd "set whichwrap+=<,>,[,],h,l"       -- allows specific characters to move to new line when at end/start
vim.cmd [[set iskeyword+=-]]               -- treat 'some-word' as one word

-- Go through the lua table as a key value pair
for k, v in pairs(options) do
    vim.opt[k] = v
end
