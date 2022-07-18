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
-- require "user.markdown"

-- Fuzzy finder - Telescope
require "user.telescope"

-- Treesitter
require "user.treesitter"

-- Utilities
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.toggleterm"
require "user.impatient"

-- Git
require "user.gitsigns"