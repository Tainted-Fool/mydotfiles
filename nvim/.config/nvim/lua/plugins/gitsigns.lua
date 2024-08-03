return {
    -- Git symbols next to line numbers
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    keys = {
            { "<leader>gh", "", desc = "hunks" },
    },
    opts = {
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- toggle with `:Gitsigns toggle_signs`
        numhl = true, -- toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = false, -- toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            ---@type string eol|overlay|right_align
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000, -- disable if file is longer than this (in lines)
        preview_config = {
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns
            local function map(mode, left, right, description)
                vim.keymap.set(mode, left, right, { buffer = buffer, desc = description })
            end
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next Hunk (gitsigns)")
            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev Hunk (gitsigns)")
            map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk (gitsigns)")
            map("n", "[H", function() gs.nav_hunk("last") end, "First Hunk (gitsigns)")
            map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line (gitsigns)")
            map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer (gitsigns)")
            map("n", "<leader>ghd", gs.diffthis, "Diff This (gitsigns)")
            map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~ (gitsigns)")
            map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline (gitsigns)")
            map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk (gitsigns)")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer (gitsigns)")
            map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer (gitsigns)")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk (gitsigns)")
            map({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk (gitsigns)")
            map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk (gitsigns)")
            map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<cr>", "Select Hunk (gitsigns)")
        end
    }
}
