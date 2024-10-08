return {
    -- Add/change/delete surrounding pairs
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
        keymaps = {
            insert = "<C-g>s",
            insert_line = "<C-g>S",
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yS",
            normal_cur_line = "ySS",
            visual = "S",
            visual_line = "gS",
            delete = "ds",
            change = "cs",
            change_line = "cS",
        },
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
