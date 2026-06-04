return {
    -- Convert between various formats
    "necrom4/convy.nvim",
    cmd = { "Convy", "ConvySeparator" },
    opts = {
        -- default configuration
        notifications = true,
        separator = " ",
        window = {
            position = "left", -- "left" or "right"
            width = 36,
        },
    },
    keys = {
        -- example keymaps
        {
            "<leader>cc",
            ":Convy<CR>",
            desc = "Convert (interactive selection)",
            mode = { "n", "v" },
            silent = true,
        },
        -- {
        --     "<leader>cd",
        --     ":Convy auto dec<CR>",
        --     desc = "Convert to decimal",
        --     mode = { "n", "v" },
        --     silent = true,
        -- },
        {
            "<leader>cs",
            ":ConvySeparator<CR>",
            desc = "Set conversion separator (visual selection)",
            mode = { "v" },
            silent = true,
        },
    }
}
