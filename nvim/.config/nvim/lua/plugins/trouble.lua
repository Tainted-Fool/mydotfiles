return {
    -- Better LSP diagnostics and quickfix list
    "folke/trouble.nvim",
    lazy = true,
    cmd = "Trouble",
    keys = {
        {
            "[q", function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous Quickfix (trouble)"
        },
        {
            "]q", function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next Quickfix (trouble)"
        },
        { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (trouble)" },
        { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions (trouble)" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (trouble)" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (trouble)" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (trouble)" },
    },
    opts = {
        position = "right",
        use_diagnostic_signs = true, -- enabling this will use the signs defined in your LSP client
    }
}
