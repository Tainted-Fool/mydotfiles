return {
    -- add highlights to buffers
    "lukas-reineke/headlines.nvim",
    -- lazy = true, -- load when nvim-tree-sitter loads
    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, headlines = pcall(require, "headlines")
        if not config_ok then
            vim.notify("headlines plugin was not found!")
            return
        end

        headlines.setup({})

    end
}
