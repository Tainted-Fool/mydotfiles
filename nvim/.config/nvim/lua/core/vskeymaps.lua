-- Set keymap function
local keymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end
-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap({ "n", "v" }, "<Space>", "<Nop>")
-- Word search is centered
keymap("n", "n", "nzz", "Repeat Previous Search Same Direction")
keymap("n", "N", "Nzz", "Repeat Previous Search Opposite Direction")
keymap("n", "*", "*zz", "Search Word Under Cursor Foward")
keymap("n", "#", "#zz", "Search Word Under Cursor Backward")
keymap("n", "g*", "g*zz", "Search Partial Word Under Cursor Foward")
keymap("n", "g#", "g#zz", "Search Partial Word Under Cursor Backward")
-- Quickly add space above/below
-- keymap("n", "[<Space>", "O<Esc>j", "Create Space Above")
-- keymap("n", "]<Space>", "o<Esc>k", "Create Space Below")
-- Comment line above/below
keymap("n", "gco", "o<esc>Ax<esc><cmd>normal gcc<cr>A<bs>", "Add Comment Below")
keymap("n", "gcO", "O<esc>Ax<esc><cmd>normal gcc<cr>A<bs>", "Add Comment Above")
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent Visual Selection Forward")
keymap("v", ">", ">gv", "Indent Visual Selection Backward")
-- Move to beginning or end of line
keymap({ "n", "o", "x" }, "<S-h>", "^", "Move to Beginning of Line")
keymap({ "n", "o", "x" }, "<S-l>", "g_", "Move to End of Line")
