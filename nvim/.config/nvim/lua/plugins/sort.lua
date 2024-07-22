return {
    "sQVe/sort.nvim",
    cmd = "Sort",
    keys = {
        { "go", "<cmd>Sort<cr>", desc = "Sort" },
        { "go", "<esc><cmd>Sort<cr>", desc = "Sort", mode = "v" },
    },
    config = function()
        require("sort").setup()
    end
}
