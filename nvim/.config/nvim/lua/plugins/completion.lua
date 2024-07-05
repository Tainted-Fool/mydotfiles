return {
    {
        -- Snippet engine
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets", -- a bunch of snippets to use
            config = function()
                -- Load snippets from VSCode
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
                end,
                expr = true, silent = true, mode = "i",
                desc = "Next snippet",
            },
            { "<c-j>", function() require("luasnip").jump(1) end, mode = "s", desc = "Next snippet" },
            { "<c-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Previous snippet" },
        }
    },
    {
        -- Auto completion
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer", -- buffer completion
            "hrsh7th/cmp-cmdline", -- cmdline completion (bugs with noice)
            "hrsh7th/cmp-path", -- path completion
            "hrsh7th/cmp-nvim-lua", -- lua completion
            "saadparwaiz1/cmp_luasnip", -- snippet completion
            "onsails/lspkind.nvim", -- lsp completion icons
            {
                "zbirenbaum/copilot-cmp", -- copilot completion
                config = function()
                    require("copilot_cmp").setup()
                end
            }
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            local icons = require("core.icons")

            -- Setup lspkind icons
            lspkind.init({
                mode = "symbol", -- "text" | "text_symbol" | "symbol_text" | "symbol"
                preset = "default", -- codicons or default
                symbol_map = {
                    Class = icons.kind.Class,
                    Color = icons.kind.Color,
                    Constant = icons.kind.Constant,
                    Constructor = icons.kind.Constructor,
                    Copilot = icons.git.Copilot,
                    Enum = icons.kind.Enum,
                    EnumMember = icons.kind.EnumMember,
                    Event = icons.kind.Event,
                    Field = icons.kind.Field,
                    File = icons.kind.File,
                    Folder = icons.kind.Folder,
                    Function = icons.kind.Function,
                    Interface = icons.kind.Interface,
                    Keyword = icons.kind.Keyword,
                    Method = icons.kind.Method,
                    Module = icons.kind.Module,
                    Operator = icons.kind.Operator,
                    Property = icons.kind.Property,
                    Reference = icons.kind.Reference,
                    Snippet = icons.kind.Snippet,
                    Struct = icons.kind.Struct,
                    Text = icons.kind.Text,
                    TypeParameter = icons.kind.TypeParameter,
                    Unit = icons.kind.Unit,
                    Value = icons.kind.Value,
                    Variable = icons.kind.Variable,
                }
            })

            cmp.setup({
                -- Completion for luasnip plugin
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },

                -- Completition key mappings
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-z>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end
                }),

                -- Menu popup configuration
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = {
                        cmp.ItemField.Abbr,
                        cmp.ItemField.Kind,
                        cmp.ItemField.Menu,
                    },
                    format = lspkind.cmp_format({
                        with_text = true,
                        max_width = 50,
                        ellipsis_char = "...",
                        show_labelDetails = true,
                    })
                },

                -- Order of source completion providers
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "copilot" },
                    { name = "path" },
                },
                {
                    { name = "buffer" },
                    -- { name = "cmdline", keyword_length = 3 },
                }),

                -- Cmp features
                experimental = {
                    ghost_text = true, -- show ghost text of first item in completion menu
                }
            })

            -- Cmdline setup for "/"
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                }
            })

            -- Cmdline setup for ":"
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                },
                {
                    {
                        name = "cmdline",
                        keyword_pattern = [=[[^[:blank:]\!]*]=],
                        keyword_length = 3,
                        option = {
                            ignore_cmds = { "Man", "!" },
                        }
                    }
                })
            })

            -- If you want to insert "(" after select function or method
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end
    }
}
