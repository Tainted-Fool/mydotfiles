-- Declare colorscheme to use
-- local colorscheme = "onehalfdark"
-- local colorscheme = "tokyonight-night"
local colorscheme = "kanagawa-wave"

-- Use protected call so we know where error is coming from
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    -- print("Something went wrong with colorscheme")
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- This is our old vimrc value
-- vim.cmd[[
--     colorscheme onehalfdark
--     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--     ]]

-- With Lazy we can return a function or a table
-- If we return a function, it will be called when the module is required
-- If we return a table, it will be used as the module
-- Return a function
-- local M = {
--     "LunarVim/darkplus.nvim",
--     lazy = false
--     priority = 1000,
-- }
-- function M.config()
--    vim.cmd.colorscheme "darkplus"
-- end
-- return M

-- Return a table
-- return {
--    "LunarVim/darkplus.nvim",
--    lazy = false
--   priority = 1000,
--    config = function()
--       vim.cmd.colorscheme "darkplus"
--    end
-- }
