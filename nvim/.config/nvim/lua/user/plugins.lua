-- Automatically install Packer
-- local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
--     PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
--     print("Installing packer close and reopen Neovim...")
--     vim.cmd([[packadd packer.nvim]])
-- end

-- Autocommand that runs 'PackerSync' whenever you save the plugins.lua file
-- vim.cmd([[
--     augroup packer_user_config
--         autocmd!
--         autocmd BufWritePost plugins.lua source <afile> | PackerSync
--     augroup end
-- ]])

-- Use protected call so we know where error is coming from
-- local status_ok, lazy = pcall(require, "lazy")
-- if not status_ok then
--     vim.notify("lazy plugin was not found!")
--     return
-- end

-- Have Packer use a popup window
-- packer.init({
--     display = {
--         open_fn = function()
--             return require("packer.util").float({
--                 border = "rounded"
--             })
--         end
--     }
-- })

-- Declare variable
-- local fn = vim.fn

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

-- Install plugins here
require("lazy").setup({
    -- Speed up Loading
    "lewis6991/impatient.nvim", -- speed up loading lua modules

    -- Startuptime Breakdown
    -- "dstein64/vim-startuptime", -- :Startuptime or nvim --startuptime

    -- Packer
    -- "wbthomason/packer.nvim", -- plugin manager

    -- Colorschemes
    "rafi/awesome-vim-colorschemes",
    "folke/tokyonight.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp", -- the auto completion plugin
    "hrsh7th/cmp-buffer", -- buffer completion
    "hrsh7th/cmp-cmdline", -- cmdline completion
    "hrsh7th/cmp-path", -- path completion
    "hrsh7th/cmp-nvim-lsp", -- lsp completion
    "hrsh7th/cmp-nvim-lua", -- lua completion
    "saadparwaiz1/cmp_luasnip", -- snippet completion

    -- Snippets
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    "neovim/nvim-lspconfig", -- enable lsp
    "williamboman/mason.nvim", -- easy install lsp servers
    "williamboman/mason-lspconfig.nvim", -- lsp configurations
    "jose-elias-alvarez/null-ls.nvim", -- formatting and linters
    "RRethy/vim-illuminate", -- highlight same symbols under cursor
    "arkav/lualine-lsp-progress", -- indicator that shows when lsp is ready
    "ray-x/lsp_signature.nvim", -- better signature help
    "lvimuser/lsp-inlayhints.nvim", -- shows data type for certain languages
    "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas
    "SmiteshP/nvim-navic", -- show current code context in winbar or statusline
    "simrat39/symbols-outline.nvim", -- show document symbols in right window
    {
        "j-hui/fidget.nvim",
        tag = "legacy"
    }, -- show lsp progress handler
    "folke/trouble.nvim", -- better lsp diagnostics and quickfix list
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- multiline diagnostics
    "onsails/lspkind.nvim", -- lsp completion icons
    "amrbashir/nvim-docs-view", -- lsp hover documentation in a side panel
    -- "vonheikemen/lsp-zero.nvim", -- zero lsp configurations
    -- "decodetalkers/csharpls-extended-lsp.nvim", -- csharp_ls extended

    -- LUA
    "nvim-lua/plenary.nvim", -- useful lua functions
    "nvim-lua/popup.nvim", -- useful lua functions
    "folke/lua-dev.nvim", -- nvim lua API docs and completion
    "rcarriga/nvim-notify", -- better notifications
    "stevearc/dressing.nvim", -- UI hook for vim.ui.select/input
    "antoinemadec/FixCursorHold.nvim", -- fix cursor hold
    "MunifTanjim/nui.nvim", -- UI component library for nvim

    -- Fuzzy Search
    "nvim-telescope/telescope.nvim", -- find files
    "nvim-telescope/telescope-file-browser.nvim", -- preview of file
    "ibhagwan/fzf-lua", -- fzf made in lua

    -- Treesitter
    "nvim-treesitter/nvim-treesitter", -- syntax highlighting
    "nvim-treesitter/nvim-treesitter-textobjects", -- syntax aware text-objects
    "p00f/nvim-ts-rainbow", -- rainbow pairs for treesitter
    "windwp/nvim-ts-autotag", -- autoclose/autorename html tags
    "JoosepAlviste/nvim-ts-context-commentstring",
    "vimjas/vim-python-pep8-indent", -- Fix treesitter auto-indent for python

    -- QOL
    "kylechui/nvim-surround", -- add/change/delete surrounding pairs
    "windwp/nvim-autopairs", -- auto pairs
    "numToStr/Comment.nvim", -- comment/uncomment
    "lukas-reineke/indent-blankline.nvim", -- adds `|` as indentation guides
    "karb94/neoscroll.nvim", -- better scrolling
    "tpope/vim-fugitive", -- git wrapper :Git <tab>
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to camel, mix, with 'crc'
    "tpope/vim-sleuth", -- Automatically adjusts 'shiftwidth' and 'expandtab'
    "justinmk/vim-sneak", -- faster motion with 's'
    -- "easymotion/vim-easymotion", -- faster motion with dash '-' '<motion>'
    "phaazon/hop.nvim", -- better navigation with f and t
    "NvChad/nvim-colorizer.lua", -- displays the hexvalue color
    "monaqa/dial.nvim", -- increment/decrement/interate various elements
    "andymass/vim-matchup", -- better % navigate and highlight matching words
    {
        "iamcco/markdown-preview.nvim", -- live markdown previewer
        build = "cd app && npm install",
        ft = "markdown"
    },
    "abecodes/tabout.nvim", -- use tab to exit quotation marks and other characters
    "ThePrimeagen/harpoon", -- mark and get file
    "folke/noice.nvim", -- replace UI for messages, cmdline, and popupmenu
    "gelguy/wilder.nvim", -- adds new features and capabilities to wildmenu
    "EtiamNullam/deferred-clipboard.nvim", -- use system clipboard
    "sudormrfbin/cheatsheet.nvim", -- cheatsheet buffer
    "gaoDean/autolist.nvim", -- auto complete list continuation and formatting
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    "Wansmer/treesj", -- split and join lines

    -- File Explorer
    "kyazdani42/nvim-tree.lua", -- tree viewer
    "kyazdani42/nvim-web-devicons", -- icons for tree view

    -- Buffers
    "moll/vim-bbye", -- close/delete buffers easier
    "akinsho/bufferline.nvim", -- buffer lines
    "nacro90/numb.nvim", -- peek lines of the buffer

    -- Terminal
    "akinsho/toggleterm.nvim", -- toggle terminal

    -- Status Bar
    "nvim-lualine/lualine.nvim", -- status bar/line

    -- Dashboard
    "goolord/alpha-nvim", -- home page
    "folke/which-key.nvim", -- show leader key bindings

    -- Sessions
    "ahmedkhalf/project.nvim", -- project manager
    "rmagatti/auto-session", -- save/restore sessions
    "rmagatti/session-lens", -- use telescope to view sessions

    -- Code Runner
    "is0n/jaq-nvim", -- run code of any language with `:`
    {
        "0x100101/lab.nvim",
        build = "cd js && npm ci"
    }, -- prototype for js, ts, lua, and python

    -- Git
    "lewis6991/gitsigns.nvim", -- git symbols

    -- Debug
    "mfussenegger/nvim-dap", -- debugger
    "rcarriga/nvim-dap-ui", -- debugger ui
    "mfussenegger/nvim-dap-python", -- dap for python
    -- "ravenxrz/DAPInstall.nvim", -- debugger installer - use Mason

    -- ai
    "github/copilot.vim", -- code ai - use :copilot setup
})
