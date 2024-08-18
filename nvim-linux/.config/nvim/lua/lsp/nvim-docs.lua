return {
    -- LSP hover documentation in a side panel
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    keys = {
        { "<leader>uc", "<cmd>DocsViewToggle <cr>", desc = "Docs Toggle (nvim-docs-view)" },
    },
    opts = {
        position = "right",
    }
}
