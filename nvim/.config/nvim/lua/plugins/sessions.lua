return {
    -- Save/restore sessions
    "rmagatti/auto-session",
    lazy = false,
    init = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    cmd = { "SessionDelete", "SessionPurgeOrphaned", "SessionRestore", "SessionSave", "SessionSearch", "SessionToggleAutoSave" },
    keys = {
        { "<leader>ur", "<cmd>SessionRestore<cr>", desc = "Restore (session)" },
        { "<leader>us", "<cmd>SessionSearch<cr>", desc = "Search (session)" },
        { "<leader>uS", "<cmd>SessionSave<cr>", desc = "Save (session)" },
        { "<leader>ua", "<cmd>SessionToggleAutoSave<cr>", desc = "Toggle Autosave (session)" },
        { "<leader>ux", "<cmd>SessionDelete<cr>", desc = "Delete (session)" },
        { "<leader>uX", "<cmd>SessionPurgeOrphaned<cr>", desc = "Remove All Orphaned (session)" },
    },
    opts = {
        log_level = "error",
        auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = {
            os.getenv("HOME"), -- if neovim is opened from $HOME, then DO NOT restore session
            "~/",
            "/",
        },
        auto_session_use_git_branch = nil,
        bypass_session_save_file_types = {
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
        }
    }
}
