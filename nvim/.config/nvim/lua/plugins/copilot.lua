return {
    -- Code ai - use :copilot setup
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        panel = {
            enabled = false, -- using nvim-cmp
            auto_refresh = false,
            keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>",
            },
            layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4,
            }
        },
        suggestion = {
            enabled = false, -- using nvim-cmp
            auto_trigger = false,
            debounce = 75,
            keymap = {
                accept = "<M-l>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            }
        },
        filetypes = {
            yaml = false,
            markdown = true,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = "node", -- node.js version must be > 18.x
        server_opts_overrides = {},
    }
}
