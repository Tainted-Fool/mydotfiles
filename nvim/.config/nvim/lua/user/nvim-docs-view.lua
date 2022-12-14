-- Use protected call so we know where error is coming from
local status_ok, docs = pcall(require, "docs-view")
if not status_ok then
	vim.notify("nvim-docs-view plugin was not found!")
	return
end

docs.setup({
  opt = true,
  cmd = { "DocsViewToggle" },
  position = "bottom",
  width = 60
})
