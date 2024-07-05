local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")
lazy.setup({
    -- Import all plugins from nvim/lua/plugins by default
    spec = {
        { import = "plugins" },
        { import = "lsp" }, -- lazy looks for all lua files in the directory
    },
    install = {
        colorscheme = { "kanagawa" },
    },
    ui = {
        border = "rounded", -- none, single, double, rounded, or shadow
        title = "Plugin Manager",
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = true,
        notify = false,
    }
})
