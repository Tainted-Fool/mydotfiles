-- Use protected call so we know where error is coming from
local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
    vim.notify("fidget plugin was not found!")
    return
end

fidget.setup()
