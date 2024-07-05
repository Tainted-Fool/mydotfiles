return {
    -- Switch between python virtualenvs
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- new 2024 version
    event = "VeryLazy",
    -- keys = {
    --     { "<leader>va", "require('venv-selector').get_active_venv()", "Get Active Virtual Env Path"},
    --     { "<leader>vc", "<cmd>VenvSelectCached<cr>", "Virtual Env Select from Cache"},
    --     { "<leader>vg", "<cmd>VenvSelectCurrent<cr>", "Get Current Virtual Env"},
    --     { "<leader>vs", "<cmd>VenvSelect<cr>", "Virtual Env Select"},
    --     { "<leader>vp", "require('venv-selector').get_active_path()", "Get Active Python Exe Path"},
    -- }
    config = function()
        require("venv-selector").setup({
            name = { "venv", ".virtualenvs" },
            auto_refresh = true,
            dap_enabled = true,
        })
    end
}
