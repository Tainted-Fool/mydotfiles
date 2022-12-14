-- Use protected call so we know where error is coming from
local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
	vim.notify("lsp_lines plugin was not found!")
	return
end

lsp_lines.setup()
