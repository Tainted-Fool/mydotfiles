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
    { "chentoast/marks.nvim", opts = {}, event = "VeryLazy" }, -- show marks in the sign column
    -- "yaocccc/vim-showmarks", -- show marks in the sign column
    -- { "lewis6991/gitsigns.nvim", opts = { signcolumn = false, numhl = true } }, -- gitsigns on the sign column
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to snake, camel, mix case 'crs', 'crc', 'crm'
    "tpope/vim-sleuth", -- Automatically adjusts 'tabstop', 'shiftwidth', and 'expandtab'
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    { "NvChad/nvim-colorizer.lua", opts = {user_default_options = {names = false}} }, -- displays the hexvalue color
    { "EtiamNullam/deferred-clipboard.nvim", opts = {failback = "unnamedplus"} }, -- use system clipboard
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
                -- win_options = {
                --     winblend = 20,
                -- },
            },
            -- preview = {
            --     win_options = {
            --         winblend = 20,
            --     }
            -- },
            -- progress = {
            --     win_options = {
            --         winblend = 20,
            --     }
            -- },
            default_file_explorer = true,
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
    -- "AckslD/swenv.nvim", -- switch between python virtualenvs
    {
        "gregorias/nvim-mapper", -- map keys with telescope
        enabled = false,
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require("nvim-mapper").setup({
                no_map = true, -- map to <leader>MM
            })
            -- require("nvim-mapper").map({ "i", "s" }, "<leader>sk", function()
            --     if ls.expand_or_jumpable() then
            --         ls.expand_or_jump(1)
            --     end
            -- end, {silent = true}, "Snippets", "snippet_jump_or_expand",
            -- "Expand or jump to next snippet placeholder")
        end,
    },

    -- Buffers
    "moll/vim-bbye", -- close/delete buffers easier :Bdelete, :Bwipeout
    { "nacro90/numb.nvim", opts = {}, event = "VeryLazy" }, -- peek lines of the buffer
    "szw/vim-maximizer", -- maximize the current buffer
    -- { "szw/vim-maximizer", opts = {}, event = "VeryLazy"}, -- maximize the current buffer

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
