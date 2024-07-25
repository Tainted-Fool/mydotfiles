return {
    -- Incremental LSP renaming
    "smjonas/inc-rename.nvim",
    enabled = false, --disable plugin
    event = "VeryLazy",
    keys = {
        { "<leader>cn", ":IncRename <c-r><c-w><left>", desc = "Rename (inc-rename)" },
    },
    opts = {},
}
