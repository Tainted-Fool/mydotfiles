-- Init.lua is the entry point for nvim

-- Speed up LUA modules loading
require("user.impatient")

-- Plugin Manager
require("user.plugins")

-- User Settings
require("user.options")
require("user.keymaps")
require("user.colorscheme")

-- Autocompletion
require("user.completion")

-- LSP
require("user.lsp")
require("user.illuminate")
-- require "user.markdown"

-- Fuzzy Finder
require("user.telescope")

-- Treesitter
require("user.treesitter")

-- Utilities
require("user.autopairs")
require("user.comment")
require("user.nvim-tree")
require("user.bufferline")
require("user.toggleterm")
require("user.lualine")
require("user.project")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.scroll")

-- Git
require("user.gitsigns")

-- Debug
require("user.dap")

-- Autocommands
require("user.autocommands")
