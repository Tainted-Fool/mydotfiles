-- Use protected call so we know where error is coming from
local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
	vim.notify("impatient plugin was not found!")
	return
end

impatient.enable_profile()
