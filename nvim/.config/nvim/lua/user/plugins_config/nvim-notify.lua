-- Use protected call so we know where error is coming from
local status_ok, notify = pcall(require, "notify")
if not status_ok then
    vim.notify("nvim-notify pluging was not found!")
    return
end

notify.setup({
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 5000,
    top_down = true
})

-- Set all vim.notify to this plugin
vim.notify = notify
