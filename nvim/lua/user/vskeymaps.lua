-- Keymaps
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Set leader key
keymap("", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes:
-- n = normal_mode
-- i = insert_mode
-- v = visual_mode
-- x = visual_block_mode
-- t = term_mode
-- c = command_mode
-- mode to use, key to map, command to run, options to set

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Add a space below or above
keymap("n", "o", "o<esc>k", opts)
keymap("n", "O", "O<esc>j", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Whichkey keymap
keymap("n", "<space>", ":call VSCodeNotify('whichkey.show')<cr>", opts)
keymap("v", "<space>", ":call VSCodeNotify('whichkey.show')<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<cr>", opts)
keymap("n", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<cr>", opts)
keymap("n", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<cr>", opts)
keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<cr>", opts)
keymap("v", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<cr>", opts)
keymap("v", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<cr>", opts)
keymap("v", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<cr>", opts)
keymap("v", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<cr>", opts)

-- Better buffer navigation
-- keymap("n", "<M-h>", ":call VSCodeNotify('workbench.action.previousEditor')<cr>", opts)
-- keymap("n", "<M-l>", ":call VSCodeNotify('workbench.action.nextEditor')<cr>", opts)
-- keymap("v", "<M-h>", ":call VSCodeNotify('workbench.action.previousEditor')<cr>", opts)
-- keymap("v", "<M-l>", ":call VSCodeNotify('workbench.action.nextEditor')<cr>", opts)

-- Move text up and down
-- keymap("n", "<M-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<M-k>", "<Esc>:m .-2<CR>==gi", opts)
-- keymap("v", "<M-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<M-k>", ":m .-2<CR>==", opts)

-- Resize with arrows
-- keymap("n", "<S-Up>", ":call VSCodeNotify('workbench.action.increaseViewSize')<cr>", opts)
-- keymap("n", "<S-Down>", ":call VSCodeNotify('workbench.action.decreaseViewSize')<cr>", opts)