return {
    -- Markdown fence block editor
    "acksld/nvim-femaco.lua",
    event = "VeryLazy",
    cmd = "FeMaco",
    keys = {
        { "<leader>cb", "<cmd>FeMaco<cr>", desc = "Edit Code Block (femaco)" }
    },
    config = true,
}
