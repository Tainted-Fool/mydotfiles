return {
    -- Startuptime Breakdown
    "dstein64/vim-startuptime", -- :Startuptime or nvim --startuptime

    -- LSP
    "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas

    -- Fuzzy Search
    "ibhagwan/fzf-lua", -- fzf made in lua

    -- QOL
    { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" }, -- add/change/delete surrounding pairs
    { "karb94/neoscroll.nvim", opts = {} }, -- better scrolling
    { "echasnovski/mini.animate", opts = {scroll = {enable = false}} }, -- animate the cursor and better scrolling
    { "chentoast/marks.nvim", opts = {}, event = "VeryLazy" }, -- marks on the sign column
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to snake, camel, mix case 'crs', 'crc', 'crm'
    "tpope/vim-sleuth", -- Automatically adjusts 'tabstop', 'shiftwidth', and 'expandtab'
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    { "NvChad/nvim-colorizer.lua", opts = {user_default_options = {names = false}} }, -- displays the hexvalue color
    { "EtiamNullam/deferred-clipboard.nvim", opts = {failback = "unnamedplus"}, lazy = true }, -- use system clipboard
    { "smjonas/inc-rename.nvim", opts = {}, event = "VeryLazy" }, -- incremental lsp renaming
    {
        "stevearc/oil.nvim", -- edit files like a normal vim buffer
        tag = "v2.8.0", -- floating window bug on latest version
        opts = {
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 2,
                max_width = 50,
                max_height = 40,
            }
        },
    },
    {
        "folke/todo-comments.nvim", -- TODO:, FIXME: and NOTE: comments
        config = function()
            require("todo-comments").setup()
            -- local keymap = function(keys, func, desc)
            --     vim.keymap.set("n", keys, func, { desc = desc, noremap = true, silent = true })
            -- end
            -- keymap("]t", function() require("todo-comments").jump_next() end, "Next todo comment")
            -- keymap("[t", function() require("todo-comments").jump_prev() end, "Previous todo comment")
            -- keymap("]t", function() require("todo-comments").jump_next({keywords = { "BUG", "WARNING" }}) end, "Next bug/warning todo comment")
        end,
        keys = {
            { "]t", "<cmd>lua require('todo-comments').jump_next()<CR>", desc = "Next todo comment" },
            { "[t", "<cmd>lua require('todo-comments').jump_prev()<CR>", desc = "Previous todo comment" },
            { "]t", "<cmd>lua require('todo-comments').jump_next({keywords = { 'BUG', 'WARNING' }})<CR>", desc = "Next bug/warning todo comment" },
        }
    },
    -- { "epwalsh/obsidian.nvim", opts = {} } -- use obsidian in neovim
    "girishji/pythondoc.vim", -- python docs

    -- Buffers
    "moll/vim-bbye", -- close/delete buffers easier :Bdelete, :Bwipeout
    { "nacro90/numb.nvim", opts = {} }, -- peek lines of the buffer
    "szw/vim-maximizer", -- maximize the current buffer

    -- Terminal
    "christoomey/vim-tmux-navigator", -- navigate between vim and tmux panes

    -- Code Runner
    {
        "0x100101/lab.nvim", -- prototype for js, ts, lua, and python
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
    },
}
