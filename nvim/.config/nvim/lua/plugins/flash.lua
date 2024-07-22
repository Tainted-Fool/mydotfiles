return {
    -- Better navigation with f, r, s, and t
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Search (Flash)" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Treesitter (Flash)" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search (Flash)" },
        { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Search (Flash)" },
    },
    opts = {
        jump = {
            autojump = true,
        },
        label = {
            rainbow = {
                enabled = true,
                shade = 2,
            }
        },
        modes = {
            search = {
                enabled = false,
            },
            char = {
                autohide = true,
                jump_labels = true,
                multi_line = false,
            }
        }
    }
}
