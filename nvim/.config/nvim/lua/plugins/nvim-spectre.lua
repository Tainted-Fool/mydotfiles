return {
    -- Search panel
    "nvim-pack/nvim-spectre",
    build = false,
    enabled = true,
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew",
    },
    keys = {
        {
            "<leader>st", function()
                require("spectre").toggle()
            end,
            desc = "Toggle (Spectre)",
        },
        {
            "<leader>sw", function()
                require("spectre").open_visual({select_word=true})
            end,
            desc = "Current Word (Spectre)",
            mode = "n",
        },
        {
            "<leader>sw", function()
                require("spectre").open_visual()
            end,
            desc = "Current Word (Spectre)",
            mode = "v",
        },
        {
            "<leader>sf", function()
                require("spectre").open_file_search({select_word = true})
            end,
            desc = "Current File (Spectre)",
        }
    }
}
