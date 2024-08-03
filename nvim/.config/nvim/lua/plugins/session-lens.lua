return {
    -- View sessions with Telescope
    "rmagatti/session-lens",
    -- event = "VeryLazy",
    cmd = { "SessionSave", "SessionDelete", "SessionRestore" },
    keys = {
        { "<leader>ur", "<cmd>SessionRestore<cr>", desc = "Restore (session)" },
        { "<leader>us", "<cmd>SessionSave<cr>", desc = "Save (sessions)" },
    },
    opts = {
        path_display = { "shorten" },
        theme_conf = {
            border = false,
        },
        previewer = true,
        prompt_title = "Sessions",
    }
}
