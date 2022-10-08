-- Use protected call so we know where error is coming from
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("mason-lspconfig.nvim plugin was not found!")
	return
end

require("user.lsp.configs")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
