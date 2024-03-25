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
                desc = "Next snippet"
            },
            -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s", desc = "Next snippet" },
            -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Previous snippet" },
            { "<c-j>", function() require("luasnip").jump(1) end, mode = "s", desc = "Next snippet" },
            { "<c-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Previous snippet" },
        }
    },
    {
        -- the auto completion plugin
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

            -- Declare variables
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- Completion function when backspace is press
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
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
                    -- ["<S-CR>"] = cmp.mapping.confirm({
                    --     behavior = cmp.ConfirmBehavior.Replace,
                    --     select = true, -- set to false to only confirm explicitly selected items
                    -- }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,

                    -- Tab autocompletion
                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     elseif has_words_before() then
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
                    --     elseif has_words_before() then -- might remove this
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
                    -- ["<C-n>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     elseif has_words_before() then
                    --         fallback()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),

                    -- Autocompletion choose previous menu item
                    -- ["<C-p>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     elseif luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
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
                    }),
                },

                -- Order of source completion providers
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "copilot" },
                    { name = "path" },
                }, { -- group_index
                    { name = "buffer" },
                    -- { name = "cmdline", keyword_length = 3 },
                }),

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

            -- If you want to insert '(' after select function or method
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end
    }
}
