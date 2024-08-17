return {
    -- Startuptime Breakdown
    "dstein64/vim-startuptime", -- :Startuptime or nvim --startuptime
    -- Quality of Life
    { "echasnovski/mini.animate", opts = { scroll = { enable = false } } }, -- animate the cursor
    { "chentoast/marks.nvim", opts = {}, event = "VeryLazy" }, -- show marks in the sign column
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-abolish", -- convert words to snake, camel, mix case "crs", "crc", "crm"
    "tpope/vim-sleuth", -- Automatically adjusts "tabstop", "shiftwidth", and "expandtab"
    -- "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    { "NvChad/nvim-colorizer.lua", opts = { user_default_options = { names = false } } }, -- displays the hexvalue color
    -- { "epwalsh/obsidian.nvim", opts = {} } -- use obsidian in neovim
    "girishji/pythondoc.vim", -- python docs
    -- "AckslD/swenv.nvim", -- switch between python virtualenvs
    -- Terminal
    "christoomey/vim-tmux-navigator", -- navigate between vim and tmux panes
}
