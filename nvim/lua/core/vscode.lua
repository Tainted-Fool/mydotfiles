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
local lazy = require("lazy")
lazy.setup({
    "tpope/vim-repeat", -- repeat last command
    -- "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to snake, camel, mix case 'crs', 'crc', 'crm'
    "tpope/vim-sleuth", -- Automatically adjusts 'tabstop', 'shiftwidth', and 'expandtab'
    {
        "sQVe/sort.nvim",
        cmd = "Sort",
        keys = {
            { "go", "<cmd>Sort<cr>", desc = "Sort (sort)" },
            { "go", "<esc><cmd>Sort<cr>", desc = "Sort (sort)", mode = "v" },
        },
        config = function()
            require("sort").setup()
        end
    },
    {
        "kylechui/nvim-surround",
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "S",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
            aliases = {
                ["a"] = ">",
                ["b"] = ")",
                ["B"] = "}",
                ["r"] = "]",
                ["q"] = { '"', "'", "`" },
                ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
            }
        }
    },
    {
        "folke/flash.nvim",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Search (Flash)" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Treesitter (Flash)" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search (Flash)" },
            { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Search (Flash)" },
        },
        opts = {
            jump = {
                autojump = true,
            },
            label = {
                rainbow = {
                    enabled = true,
                    shade = 2,
                }
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    autohide = true,
                    jump_labels = true,
                    multi_line = false,
                }
            }
        }
    },
    {
        "Wansmer/treesj",
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Join/split Lines (treesj)" },
            { "gj", "<esc><cmd>TSJToggle<cr>", desc = "Join/split Lines (treesj)", mode = "v" },
        },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
                max_join_length = 200,
            })
        end
    },
    {
        -- Syntax aware text-objects
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            { "<leader>.", desc = "Swap Parameter Forward(ts-textobject)" },
            { "<leader>,", desc = "Swap Parameter Backward(ts-textobject)" },
        },
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["a="] = "assignment.outer",
                            ["i="] = "assignment.inner",
                            ["h="] = "assignment.lhs",
                            ["l="] = "assignment.rhs",
                            ["am"] = "@function.outer",
                            ["im"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["af"] = "@call.outer",
                            ["if"] = "@call.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["al"] = "loop.outer",
                            ["il"] = "loop.inner",
                            ["ai"] = "conditional.outer",
                            ["ii"] = "conditional.inner",
                            ["a/"] = "@comment.outer",
                            ["i/"] = "@comment.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["as"] = "@statement.outer",
                            ["is"] = "@scopename.inner",
                            ["aA"] = "@attribute.outer",
                            ["iA"] = "@attribute.inner",
                            ["aF"] = "@frame.outer",
                            ["iF"] = "@frame.inner",
                        }
                    },
                    move = {
                        enable = true,
                        set_jump = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        }
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>."] = "@parameter.inner"
                        },
                        swap_previous = {
                            ["<leader>,"] = "@parameter.inner"
                        }
                    }
                }
            })
        end
    }
})
