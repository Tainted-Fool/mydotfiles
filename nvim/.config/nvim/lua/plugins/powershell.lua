return {
    -- Powershell editor integration (LSP, DAP, Terminal)
    "theleop/powershell.nvim",
    keys = {
        { "<leader>ts", "<cmd>lua require('powershell').toggle_term()<cr>", desc = "Toggle Terminal (powershell)" },
        { "<leader>de", "<cmd>lua require('powershell').eval()<cr>", desc = "Evaluate (powershell)" },
    },
    opts = {
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    }
}
