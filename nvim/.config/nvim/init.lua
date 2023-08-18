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
require("user.lsp-lines")
require("user.nvim-docs-view")
require("user.trouble")

-- Fuzzy Finder
require("user.telescope")

-- Treesitter/Syntax Highlighting
require("user.treesitter")

-- QOL
require("user.surround")
require("user.autopairs")
require("user.comment")
-- require("user.comment-test")
require("user.indentline")
require("user.scroll")
require("user.colorizer")
require("user.dressing")
require("user.dial")
require("user.hop")
require("user.tabout")
require("user.harpoon")
require("user.noice")
require("user.wilder")
require("user.clipboard")
require("user.cheatsheet")

-- File Explorer
require("user.nvim-tree")

-- Buffers
require("user.bufferline")
require("user.numb")

-- Terminal
require("user.toggleterm")

-- Status Bar
require("user.lualine")

-- Dashboard
require("user.alpha")
require("user.whichkey")
require("user.nvim-notify")

-- Sessions
require("user.project")
require("user.auto-session")

-- Code Runner
require("user.jaq")
require("user.lab")

-- Git
require("user.gitsigns")

-- Debug
require("user.dap")

-- Autocommands
require("user.autocommands")

-- Snippets
-- require("user.luasnip")
