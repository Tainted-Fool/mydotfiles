-- Use protected call so we know where error is coming from
local status_ok, lab = pcall(require, "lab")
if not status_ok then
	vim.notify("lab plugin was not found!")
	return
end

lab.setup({
	code_runner = {
		enabled = true,
	},
	quick_data = {
		enabled = false,
	},
})
