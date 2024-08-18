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
-- Better buffer navigation
keymap("n", "<A-h>", "<C-w>H", "Move Buffer Left")
keymap("n", "<A-j>", "<C-w>J", "Move Buffer Down")
keymap("n", "<A-k>", "<C-w>K", "Move Buffer Up")
keymap("n", "<A-l>", "<C-w>L", "Move Buffer Right")
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", "Increase Window Height")
keymap("n", "<C-Down>", ":resize -2<CR>", "Decrease Window Height")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease Window Width")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Increase Window Width")
-- Move lines up and down
keymap("n", "<A-Down>", ":m .+1<CR>==", "Move Line Down")
keymap("n", "<A-Up>", ":m .-2<CR>==", "Move Line Up")
-- Word search is centered
keymap("n", "n", "nzz", "Repeat Previous Search Same Direction")
keymap("n", "N", "Nzz", "Repeat Previous Search Opposite Direction")
keymap("n", "*", "*zz", "Search Word Under Cursor Foward")
keymap("n", "#", "#zz", "Search Word Under Cursor Backward")
keymap("n", "g*", "g*zz", "Search Partial Word Under Cursor Foward")
keymap("n", "g#", "g#zz", "Search Partial Word Under Cursor Backward")
-- Quickly add space above/below
keymap("n", "[<Space>", "O<Esc>j", "Create Space Above")
keymap("n", "]<Space>", "o<Esc>k", "Create Space Below")
-- Comment line above/below
keymap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
keymap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")
-- Insert mode
keymap("i", "fj", "<ESC>", "Exit Insert Mode")
-- Move lines up and down
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", "Move Line Down")
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", "Move Line Up")
-- Add undo break-points
keymap("i", ",", ",<C-g>u", "Add Undo Breakpoint")
keymap("i", ".", ".<C-g>u", "Add Undo Breakpoint")
keymap("i", ";", ";<C-g>u", "Add Undo Breakpoint")
-- Visual mode
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent Visual Selection Forward")
keymap("v", ">", ">gv", "Indent Visual Selection Backward")
-- Move lines up and down
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", "Move Line Down")
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", "Move Line Up")
-- Create a 'Number' command for auto numbering highlighted lines
vim.cmd([[command! -nargs=0 -range=% Number <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. ']])
keymap("v", "<A-a>", ":Number<CR>:nohl<CR>", "Auto Number Selected Lines")
-- Better paste
-- It deletes the selected content and drops it in the black hole register
-- and puts the content of the default register in place of the selected text
keymap("v", "p", '"_dP', "Paste From Default Register")
-- Visual block mode
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", "Move Line Down")
keymap("x", "K", ":move '<-2<CR>gv-gv", "Move Line Up")
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", "Move Line Down")
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", "Move Line Up")
-- Move to beginning or end of line
keymap({ "n", "o", "x" }, "<S-h>", "^", "Move to Beginning of Line")
keymap({ "n", "o", "x" }, "<S-l>", "g_", "Move to End of Line")
-- Save file
keymap({ "i", "n", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")
-- Enable/disable highlight group
vim.keymap.set("n", "<CR>", function()
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.hlsearch:get() then
        vim.cmd.nohl()
        return ""
    else
        return "<CR>"
    end
end, { expr = true })
