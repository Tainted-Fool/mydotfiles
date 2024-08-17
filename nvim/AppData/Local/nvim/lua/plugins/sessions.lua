return {
    -- Save/restore sessions
    "rmagatti/auto-session",
    opts = {
        log_level = "error",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = false,
        auto_session_suppress_dirs = {
            os.getenv("HOME"), -- if neovim is opened from $HOME, then DO NOT restore session
            "~/",
        },
        auto_session_use_git_branch = nil,
        bypass_session_save_file_types = {
            "alpha",
            "noice",
            "notify",
            "blank",
            "NvimTree",
            "",
            "oil",
            "lazy",
            "vim",
            "man",
            "help",
        }
    }
}
