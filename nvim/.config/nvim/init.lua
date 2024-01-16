-- Init.lua is the entry point for nvim
-- Speed up LUA modules loading
-- require("user.impatient")

-- User Keymaps
-- require("user.keymaps")

-- User Settings
require("user.options")
require("user.keymaps")

-- User Autocommands
require("user.autocommands")

-- Plugin Manager
require("user.plugins")

-- Plugin Configurations
require("user.plugins_config")

-- LSP
require("user.lsp")
