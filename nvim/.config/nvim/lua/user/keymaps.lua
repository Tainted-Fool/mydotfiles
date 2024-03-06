-- Set keymap function
local keymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes:
-- n = normal_mode - typing commands
-- i = insert_mode - typing text
-- v = visual_mode - selecting text
-- s = select_mode - selecting text and replacing it
-- x = visual_block_mode - selecting text in a block
-- t = term_mode - typing ':terminal'
-- c = command_mode - typing ':' or '/'
-- o = operator_mode - typing 'd', 'y', 'c', etc

-- Normal mode
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "Go to left window")
keymap("n", "<C-j>", "<C-w>j", "Go to lower window")
keymap("n", "<C-k>", "<C-w>k", "Go to upper window")
keymap("n", "<C-l>", "<C-w>l", "Go to right window")

    -- Tmux window navigation
-- keymap("n", "<C-S-h>", "<cmd> TmuxNavigateLeft<cr>", "Go to left tmux window")
-- keymap("n", "<C-S-j>", "<cmd> TmuxNavigateDown<cr>", "Go to lower tmux window")
-- keymap("n", "<C-S-k>", "<cmd> TmuxNavigateUp<cr>", "Go to upper tmux window")
-- keymap("n", "<C-S-l>", "<cmd> TmuxNavigateRight<cr>", "Go to right tmux window")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", "Increase window height")
keymap("n", "<C-Down>", ":resize -2<CR>", "Decrease window height")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", "Next buffer")
keymap("n", "<S-h>", ":bprevious<CR>", "Previous buffer")

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", "Move line down")
keymap("n", "<A-k>", ":m .-2<CR>==", "Move line up")

-- Word search is centered
keymap("n", "n", "nzz", "Repeat previous search same direction")
keymap("n", "N", "Nzz", "Repeat previous search opposite direction")
keymap("n", "*", "*zz", "Search word under cursor foward")
keymap("n", "#", "#zz", "Search word under cursor backward")
keymap("n", "g*", "g*zz", "Search partial word under cursor foward")
keymap("n", "g#", "g#zz", "Search partial word under cursor backward")

-- Insert mode
-- Press `fj` or `jj` to exit insert mode
keymap("i", "fj", "<ESC>", "Exit insert mode")
keymap("i", "jj", "<ESC>", "Exit insert mode")

-- Move lines up and down
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")

-- Clear search with <ESC>
-- keymap("i", "<ESC>", ":noh<CR><ESC>", "Escape and clear hlsearch")

-- Add undo break-points
keymap("i", ",", ",<C-g>u", "Add undo breakpoint")
keymap("i", ".", ".<C-g>u", "Add undo breakpoint")
keymap("i", ";", ";<C-g>u", "Add undo breakpoint")

-- Visual mode
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent visual selection forward")
keymap("v", ">", ">gv", "Indent visual selection backward")

-- Move lines up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move line down")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move line up")

-- Create a 'Number' command for auto numbering highlighted lines
vim.cmd([[command! -nargs=0 -range=% Number <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. ']])
keymap("v", "<A-a>", ":Number<CR>:nohl<CR>", "Auto number selected lines")

-- Better paste
-- It deletes the selected content and drops it in the black hole register
-- and puts the content of the default register in place of the selected text
keymap("v", "p", '"_dP', "Paste from default register")

-- Visual block mode
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", "Move line down")
keymap("x", "K", ":move '<-2<CR>gv-gv", "Move line up")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move line down")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move line up")
