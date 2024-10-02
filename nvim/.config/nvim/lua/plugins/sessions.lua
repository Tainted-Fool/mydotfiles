return {
    -- Save/restore sessions
    "rmagatti/auto-session",
    lazy = false,
    init = function()
        vim.opt.sessionoptions:append("localoptions")
    end,
    cmd = {
        "SessionDelete",
        "SessionPurgeOrphaned",
        "SessionRestore",
        "SessionSave",
        "SessionSearch",
        "SessionToggleAutoSave",
    },
    keys = {
        { "<leader>ur", "<cmd>SessionRestore<cr>", desc = "Restore (session)" },
        { "<leader>us", "<cmd>SessionSearch<cr>", desc = "Search (session)" },
        { "<leader>uS", "<cmd>SessionSave<cr>", desc = "Save (session)" },
        { "<leader>ua", "<cmd>SessionToggleAutoSave<cr>", desc = "Toggle Autosave (session)" },
        { "<leader>ux", "<cmd>SessionDelete<cr>", desc = "Delete (session)" },
        { "<leader>uX", "<cmd>SessionPurgeOrphaned<cr>", desc = "Remove All Orphaned (session)" },
    },
    opts = {
        auto_save = false,
        auto_restore = false,
        auto_restore_last_session = false,
        bypass_save_filetypes = {
            "",
            "alpha",
            "blank",
            "dashboard",
            "help",
            "lazy",
            "man",
            "noice",
            "notify",
            "NvimTree",
            "oil",
            "vim",
        },
        enabled = true,
        log_level = "error",
        root_dir = vim.fn.stdpath("data") .. "/sessions",
        suppressed_dirs = {
            "~/",
            "/",
        },
        session_lens = {
            previewer = true,
            mappings = {
                delete_session = { "i", "<C-D>" },
                alternate_session = { "i", "<C-S>" },
                copy_session = { "i", "<C-Y>" },
            }
        }
    }
}
