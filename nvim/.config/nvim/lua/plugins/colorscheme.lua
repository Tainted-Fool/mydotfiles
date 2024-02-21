return {
    {
        -- original colorscheme
        "rafi/awesome-vim-colorschemes",
        -- enabled = false, -- disable plugin

        -- config = function()
        --     vim.cmd("colorscheme onehalfdark")
        -- end
    },
    {
        -- modern colorscheme
        "folke/tokyonight.nvim",
        -- enabled = false, -- disable plugin

        -- config = function()
        --     vim.cmd("colorscheme tokyonight-moon")
        -- end
    },
    {
        -- favorite colorscheme
        "rebelot/kanagawa.nvim",
        -- enabled = false, -- disable plugin
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins

        config = function()

            -- find current highlights `:so $VIMRUNTIME/syntax/hitest.vim`
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                        ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
                        ["@markup.link.markdown_inline"] = { link = "Delimiter" }, -- !label
                        ["@markup.strong.markdown_inline"] = { link = "Identifier" }, -- **bold**
                        ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                        ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
                        ["@markup.list.markdown"] = { link = "Function" }, -- + list
                        ["@markup.link.label.markdown"] = { link = "Keyword" }, -- "label"
                        ["@markup.quote.markdown"] = { link = "DashboardIcon" }, -- > blockcode
                        ["@string.regexp"] = { link = "@string.regex" },
                        ["@variable.parameter"] = { link = "@parameter" },
                        ["@exception"] = { link = "@exception" },
                        ["@string.special.symbol"] = { link = "@symbol" },
                        ["@markup.strong"] = { link = "@text.strong" },
                        ["@markup.italic"] = { link = "@text.emphasis" },
                        ["@markup.heading"] = { link = "@text.title" },
                        ["@markup.raw"] = { link = "@text.literal" },
                        ["@markup.quote"] = { link = "@text.quote" },
                        ["@markup.math"] = { link = "@text.math" },
                        ["@markup.environment"] = { link = "@text.environment" },
                        ["@markup.environment.name"] = { link = "@text.environment.name" },
                        ["@markup.link.url"] = { link = "Special" },
                        ["@markup.link.label"] = { link = "Identifier" },
                        ["@comment.note"] = { link = "@text.note" },
                        ["@comment.warning"] = { link = "@text.warning" },
                        ["@comment.danger"] = { link = "@text.danger" },
                        ["@comment.todo"] = { link = "@text.todo" },
                        ["@diff.plus"] = { link = "@text.diff.add" },
                        ["@diff.minus"] = { link = "@text.diff.delete" },

                        -- this will make floating windows look nicer with default borders
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        -- block-lick modern Telescope UI
                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { bg = theme.ui.bg_p1, fg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { bg = theme.ui.bg_m1, fg = theme.ui.fg_dim },
                        TelescopeResultsBorder = { bg = theme.ui.bg_m1, fg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                        -- more uniform colors for the popup menu
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add blend = vim.o.pumblend to enable
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },

                        -- highlight vim-illuminate
                        IlluminatedWordText = { bg = "#49443c" },
                        IlluminatedWordRead = { bg = "#49443c" },
                        IlluminatedWordWrite = { bg = "#49443c" },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa-wave")
        end,
    },
    {
        -- best colorscheme
        "catppuccin/nvim",
        lazy = true, -- do not load plugin unless needed
        name = "catppuccin", -- require("name") then setup("opts")
        opts = {
            integrations = {
                -- theme support for other plugins highlight groups
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    }
}
