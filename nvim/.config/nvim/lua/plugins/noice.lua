return {
    -- replace UI for messages, cmdline, and popupmenu
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim", -- to render the UI
        "rcarriga/nvim-notify", -- notification manager
    },
    opts = {
        lsp = {
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = false,
                auto_open = {
                    enabled = true,
                    trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50, -- Debounce lsp signature help request by 50ms
                },
                view = nil,     -- when nil, use defaults from documentation
                ---type NoiceViewOptions
                opts = {},      -- merged with defaults from documentation
            },
            hover = {
                enabled = false,
                silent = false, -- set to true to not show a message if hover is not available
                view = nil,   -- when nil, use defaults from documentation
                ---type NoiceViewOptions
                opts = {},    -- merged with defaults from documentation
            }
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true,            -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,        -- add a border to hover docs and signature help
        },
        routes = {
            {
                -- Ignore error from `:q` with nvim-treesitter-context
                filter = { event = "msg_show", find = "nvim_win_close" },
                opts = { skip = true },
            }
        }
    }
}
