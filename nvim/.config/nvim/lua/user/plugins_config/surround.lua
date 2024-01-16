-- Use protected call so we know where error is coming from
local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
    vim.notify("nvim-surround plugin was not found!")
    return
end

surround.setup()
