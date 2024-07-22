return {
    -- Edit files like a normal vim buffer
    "stevearc/oil.nvim",
    -- tag = "v2.8.0",
    keys = {
        { "<leader>o", "<cmd>lua require('oil').open_float()<cr>", desc = "Open (Oil)" },
    },
    opts = {
        view_options = {
            show_hidden = true,
        },
        float = {
            padding = 2,
            max_width = 50,
            max_height = 40,
            win_options = {
                winblend = 20,
            }
        },
        preview = {
            win_options = {
                winblend = 20,
            }
        },
        progress = {
            win_options = {
                winblend = 20,
            }
        },
        default_file_explorer = true,
    }
}
