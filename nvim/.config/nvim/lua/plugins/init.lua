return {
    -- Startuptime Breakdown
    "dstein64/vim-startuptime", -- :Startuptime or nvim --startuptime
    -- Language Server Protocol
    "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas
    -- Fuzzy Search
    "ibhagwan/fzf-lua", -- fzf made in lua
    -- Quality of Life
    { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" }, -- add/change/delete surrounding pairs
    { "karb94/neoscroll.nvim", opts = {} }, -- better scrolling
    { "echasnovski/mini.animate", opts = { scroll = { enable = false } } }, -- animate the cursor and better scrolling
    { "chentoast/marks.nvim", opts = {}, event = "VeryLazy" }, -- show marks in the sign column
    -- "yaocccc/vim-showmarks", -- show marks in the sign column
    -- { "lewis6991/gitsigns.nvim", opts = { signcolumn = false, numhl = true } }, -- gitsigns on the sign column
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to snake, camel, mix case "crs", "crc", "crm"
    "tpope/vim-sleuth", -- Automatically adjusts "tabstop", "shiftwidth", and "expandtab"
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    { "NvChad/nvim-colorizer.lua", opts = { user_default_options = { names = false } } }, -- displays the hexvalue color
    { "EtiamNullam/deferred-clipboard.nvim", opts = { lazy = true, failback = "unnamedplus" } }, -- use system clipboard
    { "smjonas/inc-rename.nvim", opts = {}, event = "VeryLazy" }, -- incremental lsp renaming
    -- { "epwalsh/obsidian.nvim", opts = {} } -- use obsidian in neovim
    "girishji/pythondoc.vim", -- python docs
    -- "AckslD/swenv.nvim", -- switch between python virtualenvs
    -- Buffers
    "moll/vim-bbye", -- close/delete buffers easier :Bdelete, :Bwipeout
    { "nacro90/numb.nvim", opts = {}, event = "VeryLazy" }, -- peek lines of the buffer
    "szw/vim-maximizer", -- maximize the current buffer
    -- Terminal
    "christoomey/vim-tmux-navigator", -- navigate between vim and tmux panes
}
