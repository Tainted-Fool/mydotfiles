return {
    -- Split and join lines
    "Wansmer/treesj",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "gj", "<cmd>TSJToggle<cr>", desc = "Join/split Lines (treesj)" },
        { "gj", "<esc><cmd>TSJToggle<cr>", desc = "Join/split Lines (treesj)", mode = "v" },
    },
    opts = {
        use_default_keymaps = false,
        max_join_length = 200,
    }
}
