return {
    -- TODO:, FIXME: and NOTE: comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {},
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next Todo Comment (todo)"
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous Todo Comment (todo)"
        },
        { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (todo)" },
        { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (todo)" },
    }
}
