return {
    {
        -- adds `|` as indentation guides
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufEnter",
        dependencies = "hiphish/rainbow-delimiters.nvim",
        config = function()

            -- Set tab and space characters
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")
            vim.opt.listchars:append("space:·")
            vim.opt.listchars:append("tab:·→")
            vim.opt.listchars:append("extends:»")
            vim.opt.listchars:append("precedes:«")
            vim.opt.listchars:append("nbsp:‡")
            vim.opt.listchars:append("trail:↝")

            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan"
            }
            local lbl = require("ibl")
            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            lbl.setup({
                scope = { highlight = highlight },
                -- scope = { enabled = false },
                indent = {
                    -- highlight = highlight,
                    char = "│",
                    tab_char = "│",
                },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "Alpha",
                        "dashboard",
                        "NvimTree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                        "lazyterm",
                        "DressingSelect",
                        "TelescopePrompt",
                    },
                }
            })
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },
    {
        "echasnovski/mini.indentscope",
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = {
                    "help",
                    "alpha",
                    "Alpha",
                    "dashboard",
                    "NvimTree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                    "DressingSelect",
                    "TelescopePrompt",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    }
}
