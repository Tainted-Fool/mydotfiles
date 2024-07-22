return {
    {
        -- Line and block comments with `gbc` and `gcc`
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        enabled = false, -- disable plugin
        config = function()
            require("Comment").setup({
                -- Integration with nvim-ts-context-commentstring
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            })
        end
    },
    {
        -- Commentstring based on cursor location
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        enabled = false, -- disable plugin
        opts = {
            enable_autocmd = false,
        }
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        enabled = false, -- disable plugin
    }
}
