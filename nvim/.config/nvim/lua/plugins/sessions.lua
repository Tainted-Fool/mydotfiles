return {
    {
        -- Project manager
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        opts = {
            active = true,
            on_config_done = nil,
            manual_mode = false,
            detection_methods = {
                "lsp",
                "pattern",
            },
            patterns = {
                ".git",
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
            },
            ignore_lsp = {},
            exclude_dirs = {},
            show_hidden = false,
            silent_chdir = true,
            scope_chdir = "global"
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
            -- Recommended session options configurations
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
            -- vim.o.autochdir = true -- use current file dir as working dir
        end
    },
    {
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
    },
    {
        -- View sessions with Telescope
        "rmagatti/session-lens",
        -- event = "VeryLazy",
        cmd = {
            "SessionSave",
            "SessionDelete",
            "SessionRestore",
        },
        opts = {
            path_display = { "shorten" },
            theme_conf = {
                border = false,
            },
            previewer = true,
            prompt_title = "Sessions",
        }
    }
}
