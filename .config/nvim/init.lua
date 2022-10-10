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
require("user.lsp-inlayhints")
require("user.navic")
require("user.symbol-outline")
require("user.fidget")

-- Fuzzy Finder
require("user.telescope")

-- Treesitter/Syntax Highlighting
require("user.treesitter")

-- Utilities
require("user.surround")
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
