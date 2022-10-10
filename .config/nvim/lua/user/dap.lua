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
local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
	vim.notify("dap-install plugin was not found!")
	return
end

dap_install.setup({})

dap_install.config("python", {})

dapui.setup({
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
})

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

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
