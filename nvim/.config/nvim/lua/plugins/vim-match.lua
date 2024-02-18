return {
    -- better % navigate and highlight matching words
    "andymass/vim-matchup",
    -- lazy = true, -- load when nvim-tree-sitter loads
    -- enabled = false, -- disable plugin

    setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not config_ok then
            vim.notify("nvim-treesitter plugin was not found!")
            return
        end

        treesitter.setup({
            matchup = {
                enable = true,
                -- disable = { "c", "ruby" },
            }
        })

    end
}
