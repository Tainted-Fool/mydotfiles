return {
    {
        -- line and block comments with `gbc` and `gcc`
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup({
                -- Integration with nvim-ts-context-commentstring
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            })
        end
    },
    {
        -- commentstring based on cursor location
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        opts = {
            enable_autocmd = false,
        }
    }
}
