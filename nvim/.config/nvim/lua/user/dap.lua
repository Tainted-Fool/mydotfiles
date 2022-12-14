-- Use protected call so we know where error is coming from
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	vim.notify("nvim-dap plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	vim.notify("nvim-dap-ui plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local dap_py_status_ok, dap_python = pcall(require, "dap-python")
if not dap_py_status_ok then
	vim.notify("nvim-dap-python plugin was not found!")
	return
end

dapui.setup({
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5,
		border = "rounded",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

-- DAP settings for python
dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
-- dap_python.setup()

-- Open dapui when dap in initialized
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- Close dapui when dap is terminated
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

-- Close dapui when dap is exited
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
