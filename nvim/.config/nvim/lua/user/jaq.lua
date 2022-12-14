-- Use protected call so we know where error is coming from
local status_ok, jaq = pcall(require, "jaq-nvim")
if not status_ok then
	vim.notify("jaq-nvim plugin was not found!")
	return
end

jaq.setup({
	cmds = {
		-- Uses vim commands
		internal = {
			lua = "luafile %",
			vim = "source %",
		},

		-- Uses shell commands
		external = {
			markdown = "glow %",
			python = "python3 %",
			go = "go run %",
			sh = "sh %",
		},
	},

	behavior = {
		-- Default type
		default = "float", -- can be terminal

		-- Start in insert mode
		startinsert = false,

		-- Use `wincmd p` on startup
		wincmd = false,

		-- Auto-save files
		autosave = false,
	},

	-- UI settings
	ui = {
		float = {
			-- See ':h nvim_open_win'
			border = "none",

			-- See ':h winhl'
			winhl = "Normal",
			borderhl = "FloatBorder",

			-- See ':h winblend'
			winblend = 0,

			-- Num from `0-1` for measurements
			height = 0.8,
			width = 0.8,
			x = 0.5,
			y = 0.5,
		},

		-- Terminal settings
		terminal = {
			-- Window position
			position = "bot",

			-- Window size
			size = 10,

			-- Disable line numbers
			line_no = false,
		},

		quickfix = {
			-- Window position
			position = "bot",

			-- Window size
			size = 10,
		},
	},
})
