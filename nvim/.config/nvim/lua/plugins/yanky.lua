-- Better yank/paste
return {
    "gbprod/yanky.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
        highlight = { timer = 150 },
    },
    keys = {
        {
            "<leader>p",
            function()
                require("telescope").extensions.yank_history.yank_history({})
            end,
            mode = { "n", "x" },
            desc = "Open Yank History (yanky)",
        },
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text (yanky)" },
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor (yanky)" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor (yanky)" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection (yanky)" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection (yanky)" },
        { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History (yanky)" },
        { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History (yanky)" },
        { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (yanky)" },
        { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (yanky)" },
        { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (yanky)" },
        { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (yanky)" },
        { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right (yanky)" },
        { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right (yanky)" },
        { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left (yanky)" },
        { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left (yanky)" },
        { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter (yanky)" },
        { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter (yanky)" },
    }
}
