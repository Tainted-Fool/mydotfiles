-- Init.lua is the entry point for nvim

-- Plugin manager
require "user.plugins"

-- User settings
require "user.options"
require "user.keymaps"
require "user.colorscheme"

-- Autocompletion
require "user.completion"

-- LSP
require "user.lsp"

-- Fuzzy finder - Telescope
require "user.telescope"

-- Treesitter
require "user.treesitter"

-- Utilities
require "user.autopairs"
require "user.comment"