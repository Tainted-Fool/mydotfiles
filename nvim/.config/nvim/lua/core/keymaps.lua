-- Set keymap function
local keymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end
-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap({ "n", "v" }, "<Space>", "<Nop>")
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
keymap("n", "<A-h>", "<C-w>H", "Move window left")
keymap("n", "<A-j>", "<C-w>J", "Move window down")
keymap("n", "<A-k>", "<C-w>K", "Move window up")
keymap("n", "<A-l>", "<C-w>L", "Move window right")
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", "Increase window height")
keymap("n", "<C-Down>", ":resize -2<CR>", "Decrease window height")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Increase window width")
-- Move lines up and down
keymap("n", "<A-Down>", ":m .+1<CR>==", "Move line down")
keymap("n", "<A-Up>", ":m .-2<CR>==", "Move line up")
-- Word search is centered
keymap("n", "n", "nzz", "Repeat previous search same direction")
keymap("n", "N", "Nzz", "Repeat previous search opposite direction")
keymap("n", "*", "*zz", "Search word under cursor foward")
keymap("n", "#", "#zz", "Search word under cursor backward")
keymap("n", "g*", "g*zz", "Search partial word under cursor foward")
keymap("n", "g#", "g#zz", "Search partial word under cursor backward")
-- Quickly add space above/below
keymap("n", "[<Space>", "O<Esc>j", "Space above")
keymap("n", "]<Space>", "o<Esc>k", "Space below")
-- Delete marks
-- keymap("n", "dm", "<cmd>execute 'delmarks '.nr2char(getchar())<CR>", "Delete marks")
-- Insert mode
-- Press `fj` or `jj` to exit insert mode
keymap("i", "fj", "<ESC>", "Exit insert mode")
-- keymap("i", "jj", "<ESC>", "Exit insert mode")
-- Move lines up and down
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", "Move line down")
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", "Move line up")
-- Add undo break-points
keymap("i", ",", ",<C-g>u", "Add undo breakpoint")
keymap("i", ".", ".<C-g>u", "Add undo breakpoint")
keymap("i", ";", ";<C-g>u", "Add undo breakpoint")
-- Visual mode
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent visual selection forward")
keymap("v", ">", ">gv", "Indent visual selection backward")
-- Move lines up and down
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", "Move line down")
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", "Move line up")
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
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", "Move line down")
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", "Move line up")
-- Move to beginning or end of line
keymap({ "n", "o", "x" }, "<S-h>", "^")
keymap({ "n", "o", "x" }, "<S-l>", "g_")
-- Enable/disable highlight group
vim.keymap.set("n", "<CR>", function()
    --@diagnostic disable-next-line: undefined-field
    if vim.opt.hlsearch:get() then
        vim.cmd.nohl()
        return ""
    else
        return "<CR>"
    end
end, { expr = true })
