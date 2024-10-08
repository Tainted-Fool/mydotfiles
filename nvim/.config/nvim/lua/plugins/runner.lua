return {
    -- Code Runner for js, ts, lua, and python
    "0x100101/lab.nvim",
    build = "cd js && npm ci",
    event = "VeryLazy",
    cmd = "Lab",
    keys = {
        { "<leader>ci", "<cmd>Lab code panel<cr>", desc = "Infomation (lab)" },
        { "<leader>cp", "<cmd>Lab code run<cr>", desc = "Preview (lab)" },
        { "<leader>cP", "<cmd>Lab code stop<cr>", desc = "Preview Stop (lab)" },
    },
    opts = {
        code_runner = {
            enabled = true,
        },
        quick_data = {
            enabled = false,
        }
    }
}
