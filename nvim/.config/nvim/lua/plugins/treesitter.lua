return {
    {
        -- Syntax highlighting
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-context" }, -- see context in winbar
        event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- load when file is read or open
        build = ":TSUpdate", -- whenever you install or update through lazy
        cmd = { "TSUpdate", "TSUpdateSync", "TSInstall" }, -- load on these commands
        -- keys = {
        --     { "<CR>", desc = "Incremenet Selection" },
        --     { "<S-TAB>", desc = "Decrement Selection", mode = "x" },
        -- },
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "c_sharp",
                    "cpp",
                    "css",
                    "csv",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "php",
                    "python",
                    "regex",
                    "rst",
                    "ruby",
                    "sql",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                ignore_installed = { "" }, -- list of language syntax to ignore
                sync_install = false,
                auto_install = true, -- auto install language syntax that is not installed
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    -- disable = {"css"} -- list of language syntax to disable
                },
                indent = {
                    enable = true,
                    -- disable = { "python" },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        -- init_selection = "<CR>", -- bug with `q:`
                        -- scope_incremental = "<CR>",
                        node_incremental = "v",
                        node_decremental = "V",
                    }
                }
            })
        end
    },
    {
        -- Commentstring based on cursor location
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                autotag = {
                    enable = true,
                    enable_rename = true,
                    enable_close = true,
                    enable_close_on_slash = true,
                    filetypes = { "html", "xml" },
                }
            })
        end
    },
    {
        -- Syntax aware text-objects
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
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
    },
    {
        -- Better % navigate and highlight matching words
        "andymass/vim-matchup",
        event = "VeryLazy",
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                matchup = {
                    enable = true,
                    -- disable = { "c", "ruby" },
                }
            })
        end
    },
    {
        -- Split and join lines 
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
                max_join_length = 200,
            })
        end
    }
}
