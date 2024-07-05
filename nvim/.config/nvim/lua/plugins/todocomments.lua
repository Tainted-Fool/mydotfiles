return {
    -- TODO:, FIXME: and NOTE: comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    keys = {
        { "]t", "<cmd>lua require('todo-comments').jump_next()<CR>", desc = "Next todo comment" },
        { "[t", "<cmd>lua require('todo-comments').jump_prev()<CR>", desc = "Previous todo comment" },
        { "]t", "<cmd>lua require('todo-comments').jump_next({keywords = { 'BUG', 'WARNING' }})<CR>", desc = "Next bug/warning todo comment" },
    },
    config = function()
        require("todo-comments").setup()
    end
}
