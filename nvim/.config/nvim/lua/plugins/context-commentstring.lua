return {
    -- commentstring based on cursor location
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- lazy = true, -- do not load plugin unless needed
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, commentstring = pcall(require, "ts_context_commentstring")
        if not config_ok then
            vim.notify("ts_context_commentstring plugin was not found!")
            return
        end

        commentstring.setup({
            enable_autocmd = false,
        })
    end
}
