return {
    -- Multiline diagnostics
    "Tainted-Fool/lsp_lines",
    -- opts = {}, -- no options yet...
    enabled = true, -- enable/disable virtual_text
    keys = {
        { "<leader>ud",  "<cmd>lua require('lsp_lines').toggle()<cr>", desc = "Diagnostics Toggle Off (lsp-lines)" },
        { "<leader>uD", "<cmd>lua require('lsp_lines').toggle()<cr>:=vim.diagnostic.config({virtual_lines={only_current_line=true}})<cr>", desc = "Diagnostics Toggle On (lsp-lines)" },
    },
    event = "LspAttach",
    config = true,
}
