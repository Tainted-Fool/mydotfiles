return {
    -- auto complete list continuation and formatting
    "gaoDean/autolist.nvim",
    ft = {
        "markdown",
        "text",
        "tex",
        "plaintex",
        "norg",
    },

    config = function()

        local keymap = vim.keymap.set

        require("autolist").setup()
        -- keymap("n", "<ESC>", ":noh<CR><ESC>", {desc = "Escape and clear hlsearch", noremap = true, silent = true})
        -- keymap("i", "<tab>", "<cmd>AutolistTab<cr>", { desc = "AutolistTab", noremap = true, silent = true }),
        -- keymap("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>", { desc = "AutolistShiftTab", noremap = true, silent = true }),
        -- keymap("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>", {desc = "AutolistRecalculate", noremap = true, silent = true}) -- an example of using <c-t> to indent
        -- keymap("i", "<cr>", "<CR><cmd>AutolistNewBullet<cr>", {desc = "AutolistNewBullet", noremap = true, silent = true}), -- conflicts with nvim-autopairs (below didnt work)
        -- keymap("i", "<CR>", function()
        --   -- run autolist-new-bullet after the <cr> of nvim-autopairs-cr
        --   -- timeout of 0ms delays enough for my computer but you might need to adjust
        --   local timeoutms = 10
        --   vim.loop.new_timer():start(timeoutms, 0, vim.schedule_wrap(function()
        --     require("autolist").new_bullet()
        --   end))
        --
        --   require("nvim-autopairs").autopairs_cr()
        -- end, {desc = "AutolistNewBullet", noremap = true, expr = true}),
        keymap("n", "o", "o<cmd>AutolistNewBullet<cr>", { desc = "AutolistNewBullet", noremap = true, silent = true })
        keymap("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { desc = "AutolistNewBulletBefore", noremap = true, silent = true })
        keymap("n", "<cr>", "<cmd>AutolistToggleCheckbox<cr><cr>", { desc = "AutolistToggleCheckbox", noremap = true, silent = true })
        -- keymap("n", "<c-r>", "<cmd>AutolistRecalculate<cr>", {desc = "AtuolistRecalculate", noremap = true, silent = true}),

        -- cycle list types with dot-repeat
        -- keymap("n", "<leader>cn", "<cmd>AtuolistCycleNextDr<cr>", { desc = "AutolistCycleNextDr", noremap = true, silent = true, expr = true }),
        -- keymap("n", "<leader>cp", "<cmd>AtuolistCyclePrevDr<cr>", { desc = "AutolistCyclePrevDr", noremap = true, silent = true, expr = true }),

        -- if you don't want dot-repeat
        -- keymap("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>", {desc = "AutolistCycleNext", noremap = true, silent = true})
        -- keymap("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>", {desc = "AutolistCycleNext", noremap = true, silent = true})

        -- functions to recalculate list on edit
        keymap("n", ">>", ">><cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
        keymap("n", "<<", "<<<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
        keymap("n", "dd", "dd<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
        keymap("v", "d", "d<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
    end,
}
