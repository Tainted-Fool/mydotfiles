-- Declare variables
local opts = {
    noremap = true,
    silent = true
}
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

-- Set leader key
keymap("n", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes:
-- n = normal_mode
-- i = insert_mode
-- v = visual_mode and select_mode
-- s = select_mode
-- x = visual_block_mode
-- t = term_mode
-- c = command_mode
-- o = operator_mode

-- Normal mode
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", {desc = "Go to left window", noremap = true, silent = true})
keymap("n", "<C-j>", "<C-w>j", {desc = "Go to lower window", noremap = true, silent = true})
keymap("n", "<C-k>", "<C-w>k", {desc = "Go to upper window", noremap = true, silent = true})
keymap("n", "<C-l>", "<C-w>l", {desc = "Go to right window", noremap = true, silent = true})

    -- Tmux window navigation
-- keymap("n", "<C-S-h>", "<cmd> TmuxNavigateLeft<cr>", {desc = "Go to left tmux window", noremap = true, silent = true})
-- keymap("n", "<C-S-j>", "<cmd> TmuxNavigateDown<cr>", {desc = "Go to lower tmux window", noremap = true, silent = true})
-- keymap("n", "<C-S-k>", "<cmd> TmuxNavigateUp<cr>", {desc = "Go to upper tmux window", noremap = true, silent = true})
-- keymap("n", "<C-S-l>", "<cmd> TmuxNavigateRight<cr>", {desc = "Go to right tmux window", noremap = true, silent = true})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", {desc = "Increase window height", noremap = true, silent = true})
keymap("n", "<C-Down>", ":resize -2<CR>", {desc = "Decrease window height", noremap = true, silent = true})
keymap("n", "<C-Left>", ":vertical resize -2<CR>", {desc = "Decrease window width", noremap = true, silent = true})
keymap("n", "<C-Right>", ":vertical resize +2<CR>", {desc = "Increase window width", noremap = true, silent = true})

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", {desc = "Next buffer", noremap = true, silent = true})
keymap("n", "<S-h>", ":bprevious<CR>", {desc = "Previous buffer", noremap = true, silent = true})

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", {desc = "Move line down", noremap = true, silent = true})
keymap("n", "<A-k>", ":m .-2<CR>==", {desc = "Move line up", noremap = true, silent = true})
-- keymap("n", "<A-j>", "mz<Esc>:m .+1<CR>==`z", opts)
-- keymap("n", "<A-k>", "mz<Esc>:m .-2<CR>==`z", opts)

-- Word search is centered
keymap("n", "n", "nzz", {desc = "Repeat previous search same direction", noremap = true, silent = true})
keymap("n", "N", "Nzz", {desc = "Repeat previous search opposite direction", noremap = true, silent = true})
keymap("n", "*", "*zz", {desc = "Search word under cursor foward", noremap = true, silent = true})
keymap("n", "#", "#zz", {desc = "Search word under cursor backward", noremap = true, silent = true})
keymap("n", "g*", "g*zz", {desc = "Search partial word under cursor foward", noremap = true, silent = true})
keymap("n", "g#", "g#zz", {desc = "Search partial word under cursor backward", noremap = true, silent = true})

-- Clear search with <ESC>
-- keymap("n", "<ESC>", ":noh<CR><ESC>", {desc = "Escape and clear hlsearch", noremap = true, silent = true})

-- Better n and n
-- keymap("n", "n", "'Nn'[v:searchforward].'zv'", {desc = "Next search result", noremap = true, silent = true})
-- keymap("x", "n", "'Nn'[v:searchforward]", {desc = "Next search result", noremap = true, silent = true})
-- keymap("o", "n", "'Nn'[v:searchforward]", {desc = "Next search result", noremap = true, silent = true})
-- keymap("n", "N", "'nN'[v:searchforward].'zv'", {desc = "Prev search result", noremap = true, silent = true})
-- keymap("x", "N", "'nN'[v:searchforward]", {desc = "Prev search result", noremap = true, silent = true})
-- keymap("o", "N", "'nN'[v:searchforward]", {desc = "Prev search result", noremap = true, silent = true})

-- Open mousemenu
-- keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>", {desc = "Open mousemenu", noremap = true, silent = true})
-- keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>", {desc = "Open mousemenu", noremap = true, silent = true})

-- Insert mode
-- Press `fj` or `jj` to exit insert mode
keymap("i", "fj", "<ESC>", {desc = "Exit insert mode", noremap = true, silent = true})
keymap("i", "jj", "<ESC>", {desc = "Exit insert mode", noremap = true, silent = true})

-- Move lines up and down
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", {desc = "Move line down", noremap = true, silent = true})
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", {desc = "Move line up", noremap = true, silent = true})

-- Clear search with <ESC>
-- keymap("i", "<ESC>", ":noh<CR><ESC>", {desc = "Escape and clear hlsearch", noremap = true, silent = true})

-- Add undo break-points
keymap("i", ",", ",<C-g>u", {desc = "Add undo breakpoint", noremap = true, silent = true})
keymap("i", ".", ".<C-g>u", {desc = "Add undo breakpoint", noremap = true, silent = true})
keymap("i", ";", ";<C-g>u", {desc = "Add undo breakpoint", noremap = true, silent = true})

-- Visual mode
-- Stay in indent mode
keymap("v", "<", "<gv", {desc = "Indent visual selection forward", noremap = true, silent = true})
keymap("v", ">", ">gv", {desc = "Indent visual selection backward", noremap = true, silent = true})

-- Move lines up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", {desc = "Move line down", noremap = true, silent = true})
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", {desc = "Move line up", noremap = true, silent = true})
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Better paste
-- It deletes the selected content and drops it in the black hole register
-- and puts the content of the default register in place of the selected text
keymap("v", "p", '"_dP', {desc = "Paste from default register", noremap = true, silent = true})

-- Visual block mode
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", {desc = "Move line down", noremap = true, silent = true})
keymap("x", "K", ":move '<-2<CR>gv-gv", {desc = "Move line up", noremap = true, silent = true})
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", {desc = "Move line down", noremap = true, silent = true})
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", {desc = "Move line up", noremap = true, silent = true})

-- Better paste
-- It deletes the selected content and drops it in the black hole register
-- and puts the content of the default register in place of the selected text
-- keymap("x", "p", '[["_dP]]', {desc = "Paste from default register", noremap = true, silent = true})

-- keymap("n", "<leader>ur", ':nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', {desc = "Redraw/clear hlsearch/diff update", noremap = true, silent = true})
