-- Use a protected call so we know where error is coming from
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	vim.notify("toggleterm plugin was not found!")
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\]],
	hide_numbers = true,
	shade_filetypes = {},
	share_Terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	local bufkeymap = vim.api.nvim_buf_set_keymap

	bufkeymap(0, "t", "<ESC>", [[<C-\><C-n>]], opts)
	bufkeymap(0, "t", "fj", [[<C-\><C-n>]], opts)
	bufkeymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	bufkeymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	bufkeymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	bufkeymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
	ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end
