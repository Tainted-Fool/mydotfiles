return {
    -- Switch between python virtualenvs
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- new 2024 version
    event = "VeryLazy",
    keys = {
        { "<leader>v", "", desc = "venv" },
        { "<leader>va", "require('venv-selector').get_active_venv()", desc = "Get Active Path (venv)"},
        { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select from Cache (venv)"},
        { "<leader>vg", "<cmd>VenvSelectCurrent<cr>", desc = "Get Current (venv)"},
        { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select (venv)"},
        { "<leader>vp", "require('venv-selector').get_active_path()", desc = "Get Current Python (venv)"},
    },
    config = function()
        require("venv-selector").setup({
            name = { "venv", ".virtualenvs" },
            auto_refresh = true,
            dap_enabled = true,
        })
    end
}
