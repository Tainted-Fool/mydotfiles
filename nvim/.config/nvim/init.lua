-- Init.lua is the entry point for nvim

-- User Settings
require("user.options")
require("user.keymaps")

-- User Autocommands
require("user.autocommands")

-- Plugin Manager
require("user.lazy")
