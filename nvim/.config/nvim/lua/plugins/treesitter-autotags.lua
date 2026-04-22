return {
    -- Commentstring based on cursor location
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        local treesitter = require("nvim-treesitter.config")
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
