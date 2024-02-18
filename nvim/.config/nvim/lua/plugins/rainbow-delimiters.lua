return {
    "hiphish/rainbow-delimiters.nvim",
    -- lazy = true, -- load when nvim-tree-sitter loads
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, rainbow_delimiters = pcall(require, "rainbow-delimiters.setup")
        if not config_ok then
            vim.notify("rainbow-delimiters plugin was not found!")
            return
        end

        rainbow_delimiters.setup({})
    end
}
