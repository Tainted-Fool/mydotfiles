return {
    -- commentstring based on cursor location
    "windwp/nvim-ts-autotag",
    -- lazy = true, -- do not load plugin unless needed
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not config_ok then
            vim.notify("nvim-ts-autotag plugin was not found!")
            return
        end

        treesitter.setup({
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = { "html", "xml" },
            }
        })
    end
}
