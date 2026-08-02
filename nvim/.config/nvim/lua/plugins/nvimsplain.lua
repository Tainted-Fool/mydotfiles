return {
    -- Explain vim/nvim commands
    "Tainted-Fool/nvimsplain",
    cmd = { "Vimsplain", "VimsplainReg" },
    keys = {
        { "<leader>cv", "<cmd>Vimsplain<cr>", desc = "Explain Command (nvimsplain)" },
        { "<leader>cV", "<cmd>VimsplainReg<cr>", desc = "Explain Register (nvimsplain)" },
    },
}
