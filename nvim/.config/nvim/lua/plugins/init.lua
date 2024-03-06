-- This file is optional when using lazy
return {
    -- Speed up Loading
    "lewis6991/impatient.nvim", -- speed up loading lua modules

    -- Startuptime Breakdown
    -- "dstein64/vim-startuptime", -- :Startuptime or nvim --startuptime

    -- Packer
    -- "wbthomason/packer.nvim", -- plugin manager (legacy)

    -- Colorschemes
    -- "rafi/awesome-vim-colorschemes", (done)
    -- "folke/tokyonight.nvim", (done)
    -- "rebelot/kanagawa.nvim", (done)

    -- Autocompletion
    -- "hrsh7th/nvim-cmp", -- the auto completion plugin (done)
    -- "hrsh7th/cmp-buffer", -- buffer completion (done)
    -- "hrsh7th/cmp-cmdline", -- cmdline completion (bugs with noice) (done)
    -- "hrsh7th/cmp-path", -- path completion (done)
    -- "hrsh7th/cmp-nvim-lsp", -- lsp completion (done)
    -- "hrsh7th/cmp-nvim-lua", -- lua completion (done)
    -- "saadparwaiz1/cmp_luasnip", -- snippet completion (done)
    -- "zbirenbaum/copilot-cmp", -- copilot completion (done)

    -- Snippets
    -- "L3MON4D3/LuaSnip", -- snippet engine (done)
    -- "rafamadriz/friendly-snippets", -- a bunch of snippets to use (done)

    -- LSP
    -- "neovim/nvim-lspconfig", -- enable lsp (done)
    -- "williamboman/mason.nvim", -- easy install lsp servers (done)
    -- "williamboman/mason-lspconfig.nvim", -- lsp configurations (done)
    -- "whoissethdaniel/mason-tool-installer.nvim", -- install and upgrade Mason tools (done)
    -- "nvimtools/none-ls.nvim", -- formatters and linters community driven (done)
    -- "RRethy/vim-illuminate", -- highlight same symbols under cursor (done)
    -- "arkav/lualine-lsp-progress", -- indicator that shows when lsp is ready (done)
    -- "ray-x/lsp_signature.nvim", -- better signature help (done)
    -- "lvimuser/lsp-inlayhints.nvim", -- shows data type for certain languages (done)
    "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas
    -- "SmiteshP/nvim-navic", -- show current code context in winbar or statusline (done)
    -- "LunarVim/breadcrumbs.nvim", -- provides context about your code in winbar (done)
    -- "simrat39/symbols-outline.nvim", -- show document symbols in right window (done)
    -- {
    --   "j-hui/fidget.nvim",
    --   tag = "legacy"
    -- }, -- show lsp progress handler (done)
    -- "folke/trouble.nvim", -- better lsp diagnostics and quickfix list (done)
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- multiline diagnostics (done)
    -- "onsails/lspkind.nvim", -- lsp completion icons (done)
    -- "amrbashir/nvim-docs-view", -- lsp hover documentation in a side panel (done)
    -- "vonheikemen/lsp-zero.nvim", -- zero lsp configurations
    -- "decodetalkers/csharpls-extended-lsp.nvim", -- csharp_ls extended

    -- LUA
    -- "nvim-lua/plenary.nvim", -- useful lua functions (done)
    -- "nvim-lua/popup.nvim", -- useful lua functions (done)
    "folke/lua-dev.nvim", -- nvim lua API docs and completion
    -- "rcarriga/nvim-notify", -- better notifications (done)
    -- "stevearc/dressing.nvim", -- UI hook for vim.ui.select/input (done)
    "antoinemadec/FixCursorHold.nvim", -- fix cursor hold
    -- "MunifTanjim/nui.nvim", -- UI component library for nvim (done)

    -- Fuzzy Search
    -- "nvim-telescope/telescope.nvim", -- find files (open)
    -- "nvim-telescope/telescope-file-browser.nvim", -- preview of file (done)
    -- "nvim-telescope/telescope-ui-select.nvim", -- UI for telescope (done)
    -- {
    --   "nvim-telescope/telescope-fzf-native.nvim", -- fzf sorter for telescope (done)
    --   build = "make",
    -- },
    "ibhagwan/fzf-lua", -- fzf made in lua

    -- Treesitter
    -- "nvim-treesitter/nvim-treesitter", -- syntax highlighting (done)
    -- "nvim-treesitter/nvim-treesitter-textobjects", -- syntax aware text-objects (done)
    -- "p00f/nvim-ts-rainbow", -- rainbow pairs for treesitter (legacy)
    -- "windwp/nvim-ts-autotag", -- autoclose/autorename html tags (done)
    -- "JoosepAlviste/nvim-ts-context-commentstring", (done)
    -- "vimjas/vim-python-pep8-indent", -- Fix treesitter auto-indent for python

    -- QOL
    { "kylechui/nvim-surround", opts = {} }, -- add/change/delete surrounding pairs
    -- "windwp/nvim-autopairs", -- auto pairs
    -- "numToStr/Comment.nvim", -- comment/uncomment (done)
    -- "lukas-reineke/indent-blankline.nvim", -- adds `|` as indentation guides (done)
    { "karb94/neoscroll.nvim", opts = {} }, -- better scrolling
    -- "tpope/vim-fugitive", -- git wrapper :Git <tab>
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to camel, mix, with 'crc'
    "tpope/vim-sleuth", -- Automatically adjusts 'tabstop', 'shiftwidth', and 'expandtab'
    -- "justinmk/vim-sneak", -- faster motion with 's'
    -- "easymotion/vim-easymotion", -- faster motion with dash '-' '<motion>'
    -- "phaazon/hop.nvim", -- better navigation with f and t (legacy)
    -- "smoka7/hop.nvim", -- better navigation with f and t
    -- "folke/flash.nvim", -- better navigation with f and t (updated) (done)
    { "NvChad/nvim-colorizer.lua", opts = {} }, -- displays the hexvalue color
    -- "monaqa/dial.nvim", -- increment/decrement/interate various elements (done)
    -- "andymass/vim-matchup", -- better % navigate and highlight matching words (done)
    -- "abecodes/tabout.nvim", -- use tab to exit quotation marks and other characters (done)
    -- "ThePrimeagen/harpoon", -- mark and get file (done)
    -- "folke/noice.nvim", -- replace UI for messages, cmdline, and popupmenu (done)
    -- "gelguy/wilder.nvim", -- adds new features and capabilities to wildmenu
    { "EtiamNullam/deferred-clipboard.nvim", opts = {failback = "unnamedplus"} }, -- use system clipboard
    -- "sudormrfbin/cheatsheet.nvim", -- cheatsheet buffer (done)
    -- "gaoDean/autolist.nvim", -- auto complete list continuation and formatting (done)
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    -- "Wansmer/treesj", -- split and join lines (done)
    { "stevearc/oil.nvim", opts = {} }, -- edit files like a normal vim buffer
    "epwalsh/obsidian.nvim", -- use obsidian in neovim
    { "folke/todo-comments.nvim", opts = {} },

    -- File Explorer
    -- "kyazdani42/nvim-tree.lua", -- tree viewer (done)
    -- "kyazdani42/nvim-web-devicons", -- icons for tree view (done)

    -- Buffers
    "moll/vim-bbye", -- close/delete buffers easier
    -- "akinsho/bufferline.nvim", -- buffer lines (done)
    { "nacro90/numb.nvim", opts = {} }, -- peek lines of the buffer

    -- Terminal
    -- "akinsho/toggleterm.nvim", -- toggle terminal (done)
    "christoomey/vim-tmux-navigator", -- navigate between vim and tmux panes (done)

    -- Status Bar
    -- "nvim-lualine/lualine.nvim", -- status bar/line (done)

    -- Dashboard
    -- "goolord/alpha-nvim", -- home page (done)
    -- "folke/which-key.nvim", -- show leader key bindings (done)

    -- Sessions
    -- "ahmedkhalf/project.nvim", -- project manager save editing state (done)
    -- "rmagatti/auto-session", -- save/restore sessions (done)
    -- "rmagatti/session-lens", -- use telescope to view sessions (done)

    -- Code Runner
    -- "is0n/jaq-nvim", -- run code of any language with `:` (done)
    {
        "0x100101/lab.nvim",
        build = "cd js && npm ci",
        event = "VeryLazy",
        opts = {
            code_runner = {
                enabled = true
            },
            quick_data = {
                enabled = false
            }
        }
    }, -- prototype for js, ts, lua, and python

    -- Git
    -- "lewis6991/gitsigns.nvim", -- git symbols (done)

    -- Debug
    -- "mfussenegger/nvim-dap", -- debug adapter protocol (done)
    -- "rcarriga/nvim-dap-ui", -- debugger ui (done)
    -- "mfussenegger/nvim-dap-python", -- dap for python (done)
    -- "ravenxrz/DAPInstall.nvim", -- debugger installer - use Mason

    -- AI
    -- "zbirenbaum/copilot.lua", -- code ai - use :copilot setup (done)
    -- "AndreM222/copilot-lualine", -- copilot lualine integration (done)
    -- "jackmort/chatgpt.nvim", -- chat with gpt3 (done)
}
