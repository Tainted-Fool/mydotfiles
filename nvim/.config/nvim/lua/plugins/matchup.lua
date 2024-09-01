return {
    -- Better % navigate and highlight matching words
    "andymass/vim-matchup",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "%", desc = "Match Pairs (vim-matchup)" },
    },
    setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            matchup = {
                enable = true,
                -- disable = { "c", "ruby" },
            }
        })
    end
}
