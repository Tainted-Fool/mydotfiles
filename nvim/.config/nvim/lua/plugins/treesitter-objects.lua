return {
    -- syntax aware text-objects
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- lazy = true, -- load when nvim-tree-sitter loads
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not config_ok then
            vim.notify("nvim-treesitter-objects plugin was not found!")
            return
        end

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
                    },
                },
                move = {
                    enable = true,
                    set_jump = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>."] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>,"] = "@parameter.inner",
                    },
                },
            },
        })
    end,
}
