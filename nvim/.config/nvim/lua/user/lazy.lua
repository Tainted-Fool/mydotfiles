-- Lazy install
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
  -- import all plugins from nvim/lua/plugins
  -- lazy looks for all lua files in the plugins directory
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded", -- none, single, double, rounded, or shadow
    title = "Plugin Manager",
  },
  checker = {
    enabled = true,
  },
})
