-- Init.lua is the entry point for nvim

-- User Settings
require("user.options")
require("user.keymaps")

-- User Autocommands
require("user.autocommands")

-- Plugin Manager
-- require("user.plugins")

-- transition to lazy loading
require("user.lazy")

-- Plugin Configurations
require("user.plugins_config")

-- LSP
require("user.lsp")
