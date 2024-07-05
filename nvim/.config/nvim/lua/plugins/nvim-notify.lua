return {
    -- Better notifications
    "rcarriga/nvim-notify",
    opts = {
        render = "minimal",
        timeout = 3000,
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end
}
