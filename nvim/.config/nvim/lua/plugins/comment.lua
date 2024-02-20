return {
    -- line and block comments with `gbc` and `gcc`
    "numToStr/Comment.nvim",
    -- lazy = false,
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, comment = pcall(require, "Comment")
        if not config_ok then
            vim.notify("Comment plugin was not found!")
            return
        end

        comment.setup({
            -- Integration with nvim-ts-context-commentstring
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
        })
    end
}
