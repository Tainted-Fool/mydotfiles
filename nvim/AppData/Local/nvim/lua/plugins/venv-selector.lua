return {
    -- Switch between python virtualenvs
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- new 2024 version
    event = "VeryLazy",
    cmd = "VenvSelect",
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Select (venv)"},
    },
    opts = {
            name = { "venv", ".virtualenvs" },
            auto_refresh = true,
            dap_enabled = true,
    }
}
