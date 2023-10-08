-- Use protected call so we know where error is coming from
local status_ok, deferred = pcall(require, "deferred-clipboard")
if not status_ok then
    vim.notify("deferred-clipboard plugin was not found!")
end

deferred.setup({
    failback = "unnamedplus" -- or your preferred settings for clipboard
})
