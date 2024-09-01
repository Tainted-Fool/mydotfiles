return {
    -- LSP inlay hints at the end of line
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    keys = {
        { "<leader>uh", "<cmd>lua require('lsp-endhints').toggle()<cr>", desc = "Toggle Endhints/Inlay (lsp-endhints)" }
    },
    opts = {
        label = {
            padding = 1,
            marginLeft = 0,
            bracketedParameters = true,
        },
        autoEnableHints = true,
    }
}
