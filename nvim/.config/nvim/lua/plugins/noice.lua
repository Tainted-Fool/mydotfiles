return {
    -- Replace UI for messages, cmdline, and popupmenu
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        { "MunifTanjim/nui.nvim", lazy = true }, -- to render the UI
        "rcarriga/nvim-notify", -- notification manager
    },
    keys = {
        { "<leader>sn", "", desc = "noice" },
        { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message (Noice)" },
        { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History (Noice)" },
        { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All (Noice)" },
        { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All (Noice)" },
        { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Noice)" },
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline (Noice)" },
    },
    opts = {
        lsp = {
            override = {
                -- Override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- Override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- Override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = false,
                auto_open = {
                    enabled = true,
                    trigger = true, -- automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- will open signature help when jumping to Luasnip insert nodes
                    throttle = 50, -- debounce lsp signature help request by 50ms
                },
                view = nil, -- when nil, use defaults from documentation
                opts = {}, -- merged with defaults from documentation
            },
            hover = {
                enabled = false,
                silent = false, -- set to true to not show a message if hover is not available
                view = nil, -- when nil, use defaults from documentation
                opts = {}, -- merged with defaults from documentation
            }
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
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
