return {
    -- Add/change/delete surrounding pairs
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
        aliases = {
            ["a"] = ">",
            ["p"] = ")", -- default:b
            ["c"] = "}", -- default:B
            ["b"] = "]", -- default:r
            ["q"] = { '"', "'", "`" },
            ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        }
    }
}
