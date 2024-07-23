return {
    -- Incremental LSP renaming
    "smjonas/inc-rename.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>cn", ":IncRename ", desc = "Rename (inc-rename)" },
    },
    opts = {},
}
