-- Declare colorscheme to use
local colorscheme = "tokyonight"

-- Use protected call so we know where error is coming from
local status_ok, theme = pcall(vim.cmd, "colorscheme " .. colorscheme)
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