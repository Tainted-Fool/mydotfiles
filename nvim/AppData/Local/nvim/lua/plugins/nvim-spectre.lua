return {
    -- Search and replace panel
    "nvim-pack/nvim-spectre",
    build = false,
    enabled = true,
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew",
        live_update = true,
        is_insert_mode = true,
        find_engine = {
            ["rg"] = {
                cmd = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--hidden",
                    "--no-ignore",
                    "--no-ignore-vcs",
                },
            }
        }
    },
    keys = {
        {
            "<leader>sF", function()
                require("spectre").open_file_search({ select_word = false })
            end,
            desc = "Current File (spectre)",
        },
        {
            "<leader>sR", function()
                require("spectre").toggle()
            end,
            desc = "Replace All (spectre)",
        },
        {
            "<leader>sS", function()
                require("spectre").open_file_search({ select_word = true })
            end,
            desc = "Current File and Word (spectre)",
        },
        {
            "<leader>sW", function()
                require("spectre").open_visual({ select_word = true })
            end,
            desc = "Current Word (spectre)",
            mode = "n",
        },
        {
            "<leader>sW", function()
                require("spectre").open_visual()
            end,
            desc = "Current Word (spectre)",
            mode = "v",
        }
    }
}
