return {
    -- the auto completion plugin
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer", -- buffer completion
        "hrsh7th/cmp-cmdline", -- cmdline completion (bugs with noice)
        "hrsh7th/cmp-path", -- path completion
        "hrsh7th/cmp-nvim-lua", -- lua completion
        "saadparwaiz1/cmp_luasnip", -- snippet completion
        "L3MON4D3/LuaSnip", -- snippet engine
        "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        "onsails/lspkind.nvim", -- lsp completion icons
        {
            "zbirenbaum/copilot-cmp", -- copilot completion
            config = function()
                require("copilot_cmp").setup()
            end
        }
    },
    config = function()

        -- Declare variables
        local cmp = require("cmp")
        -- local types = require("cmp.types")
        -- local str = require("cmp.utils.str")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Load snippets from VSCode
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Completion function when backspace is press
        local check_backspace = function()
            local col = vim.fn.col(".") - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
        end

        lspkind.init({
            mode = "symbol", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            preset = "default", -- codicons or default
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
                Copilot = "",
            },
        })

        cmp.setup({
            -- Completion for luasnip plugin
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Completition key mappings
            mapping = {
                -- ["<C-k>"] = cmp.mapping.select_prev_item(),
                -- ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-1),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-z>"] = cmp.mapping.complete(),
                -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
                ["<C-e>"] = cmp.mapping.close(),

                ["<CR>"] = cmp.mapping.confirm({
                    select = false,
                }), -- set to false to only confirm explicitly selected items
                -- ["<Right>"] = cmp.mapping.confirm({ select = true }),
                -- ["<C-y>"] = cmp.mapping.confirm({
                --     behavior = cmp.ConfirmBehavior.Insert, -- or Replace
                --     select = true, -- accept currently selected item
                -- }),

                -- Tab autocompletion
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif luasnip.expand_or_jumpable() then
                --         luasnip.expand_or_jump()
                --     elseif check_backspace() then
                --         fallback()
                --     else
                --         fallback()
                --     end
                -- end, {"i", "s"}),

                -- -- Same as TAB but backwards
                -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, {"i", "s"})

                -- Tab autocompletion with copilot
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     local copilot = require("copilot.suggestion")
                --     if copilot.is_visible() then
                --         copilot.accept()
                --     elseif cmp.visible() then
                --         local entry = cmp.get_selected_entry()
                --         if not entry then
                --             cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                --         else
                --             cmp.confirm()
                --         end
                --     elseif luasnip.expand_or_jumpable() then
                --         luasnip.expand_or_jump()
                --     elseif check_backspace() then
                --         fallback()
                --     else
                --         fallback()
                --     end
                -- end, {"i", "s"}),

                -- Same as TAB for copilot but backwards
                -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                --     local copilot = require("copilot.suggestion")
                --     if copilot.is_visible() then
                --         copilot.accept()
                --     elseif cmp.visible() then
                --         local entry = cmp.get_selected_entry()
                --         if not entry then
                --             cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                --         else
                --             cmp.confirm()
                --         end
                --     elseif luasnip.jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, {"i", "s"}),

                -- Autocompletion choose next menu item
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Autocompletion choose previous menu item
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Autocompletion choose next menu item
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Autocompletion choose previous menu item
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },

            -- Menu popup configuration
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
                -- scrollbar =  cmp.window.completion.scrollbar(false),
                completion = {
                    border = "shadow", -- none, single, double, rounded, or shadow
                    scrollbar = false,
                },
                documentation = {
                    border = "shadow",
                },
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
                }),
            },

            -- Order of source completion providers
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "copilot" },
                { name = "buffer" },
                { name = "path" },
                -- { name = "cmdline", keyword_length = 3 },
            },

            -- Comfirmation options
            -- confirm_opts = {
            -- behavior = cmp.ConfirmBehavior.Replace,
            -- select = false,
            -- },

            -- Cmp features
            experimental = {
                ghost_text = true, -- show ghost text of first item in completion menu
            },
        })

        -- Cmdline setup for '/'
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Cmdline setup for ':'
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                    {
                        name = "cmdline",
                        keyword_pattern = [=[[^[:blank:]\!]*]=],
                        keyword_length = 3,
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
        })
    end
}
