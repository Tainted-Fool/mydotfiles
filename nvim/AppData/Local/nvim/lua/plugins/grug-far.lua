return {
    -- Grug Find and Replace
    "magicduck/grug-far.nvim",
    opts = {
        extraRgArgs = "--hidden --no-ignore --no-ignore-vcs",
        headerMaxWidth = 80,
        keymaps = {
            replace = { n = "<leader>R" },
            qflist = { n = "<leader>Q" },
            syncLocations = { n = "<leader>S" },
            syncLine = { n = "<leader>l" },
            close = { n = "<leader>C" },
            historyOpen = { n = "<leader>T" },
            historyAdd = { n = "<leader>A" },
            refresh = { n = "<leader>F" },
            openLocation = { n = "<leader>o" },
            gotoLocation = { n = "<enter>" },
            abort = { n = "<leader>B" },
            help = { n = "g?" },
            toggleShowRgCommand = { n = "<leader>p" },
        }
    },
    cmd = "GrugFar",
    keys = {
        {
            "<leader>sf", function()
                require("grug-far").grug_far({
                    transient = true,
                    prefills = {
                        filesFilter = vim.fn.expand("%:t") -- current filename with extension
                    }
                })
            end,
            mode = { "n", "v" },
            desc = "Current File (grug-far)",
        },
        {
            "<leader>sr", function()
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e") -- :h filename-modifiers
                require("grug-far").grug_far({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil
                    }
                })
            end,
            mode = { "n", "v" },
            desc = "Replace All (grug-far)"
        },
        {
            "<leader>ss", function()
                require("grug-far").grug_far({
                    transient = true,
                    prefills = {
                        filesFilter = vim.fn.expand("%:t"), -- current filename with extension
                        search = vim.fn.expand("<cword>"), -- current word under cursor
                    }
                })
            end,
            mode = { "n", "v" },
            desc = "Current File and Word (grug-far)"
        },
        {
            "<leader>sw", function()
                require("grug-far").grug_far({
                    transient = true,
                    prefills = {
                        search = vim.fn.expand("<cword>"), -- current word under cursor
                    }
                })
            end,
            mode = { "n", "v" },
            desc = "Current Word (grug-far)",
        }
    }
}
