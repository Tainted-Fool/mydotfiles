return {
    "the-silent-one/goose.nvim",
    keys = {
        { "<leader>GG", "<cmd>lua require('goose').hatch()<cr>", desc = "Goose Hatch" },
        { "<leader>GK", "<cmd>lua require('goose').cook()<cr>", desc = "Goose Cook" },
    },
    config = true
}
