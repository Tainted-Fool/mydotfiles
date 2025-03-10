return {
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
                        ["]a"] = "@parameter.inner",
                        ["]c"] = "@class.outer",
                        ["]f"] = "@function.outer",
                        ["]l"] = "@block.outer",
                    },
                    goto_next_end = {
                        ["]A"] = "@parameter.inner",
                        ["]C"] = "@class.outer",
                        ["]F"] = "@function.outer",
                        ["]L"] = "@block.outer",
                    },
                    goto_previous_start = {
                        ["[a"] = "@parameter.inner",
                        ["[c"] = "@class.outer",
                        ["[f"] = "@function.outer",
                        ["[l"] = "@block.inner",
                    },
                    goto_previous_end = {
                        ["[A"] = "@parameter.inner",
                        ["[C"] = "@class.outer",
                        ["[F"] = "@function.outer",
                        ["[L"] = "@block.inner",
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
