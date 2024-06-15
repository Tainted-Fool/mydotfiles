return {
    ---@param msg string the notification body
    ---@param type number|nil the type of the notification (:h vim.log.levels)
    ---@param opts? table the nvim-notify options to use (:h notify-options)
    mynotify = function(msg, type, opts)
        vim.notify(msg, type, vim.tbl_deep_extend("force", { title = "Neovim" }, opts or {}))
    end
}
-- local M = {}
-- ---@param msg string the notification body
-- ---@param type number|nil the type of the notification (:h vim.log.levels)
-- ---@param opts? table the nvim-notify options to use (:h notify-options)
-- M.mynotify = function(msg, type, opts)
-- vim.notify(msg, type, vim.tbl_deep_extend("force", { title = "Neovim" }, opts or {}))
--     end
-- return M
