return {
    "the-silent-one/goose.nvim",
    keys = {
        { "<leader>Gh", "<cmd>lua require('goose').hatch()<cr>", desc = "Hatch (goose)" },
        { "<leader>Gc", "<cmd>lua require('goose').cook()<cr>", desc = "Cook (goose)" },
    },
    config = true
}
