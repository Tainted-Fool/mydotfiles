return {
    -- Powershell editor integration (LSP, DAP, Terminal)
    "theleop/powershell.nvim",
    opts = {
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    }
}
