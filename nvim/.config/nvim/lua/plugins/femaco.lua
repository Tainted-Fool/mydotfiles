return {
    -- Markdown fence block editor
    "gen4438/nvim-femaco.lua",
    event = "VeryLazy",
    cmd = "FeMaco",
    keys = {
        { "<leader>cb", "<cmd>FeMaco<cr>", desc = "Edit Code Block (femaco)" }
    },
    config = true,
}
