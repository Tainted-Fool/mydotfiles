return {
    {
        -- project manager
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        opts = {
            active = true,
            on_config_done = nil,
            manual_mode = false,
            detection_methods = {"lsp", "pattern"},
            patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json"},
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
        end
    },
    {
        -- save/restore sessions
        "rmagatti/auto-session",
        -- BUG: auto-session is not working with lazy
        -- init = function()
        --     local function restore()
        --         if vim.fn.argc(-1) > 0 then
        --             return
        --         end
        --         vim.schedule(function()
        --             require("auto-session").AutoRestoreSession()
        --         end)
        --     end
        --     local lazy_view_win = nil
        --     vim.api.nvim_create_autocmd("User", {
        --         pattern = { "AlphaReady", "VeryLazy" },
        --         callback = function()
        --             local lazy_view = require("lazy.view")
        --             if lazy_view.visible() then
        --                 lazy_view_win = lazy_view.view.win
        --             else
        --                 restore()
        --             end
        --         end,
        --     })
        --     vim.api.nvim_create_autocmd("WinClosed", {
        --         callback = function(event)
        --             if not lazy_view_win or event.match ~= tostring(lazy_view_win) then
        --                 return
        --             end
        --             restore()
        --         end,
        --     })
        -- end,

        opts = {
            log_level = "error",
            auto_session_enable_last_session = false,
            auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            auto_session_enabled = false,
            auto_save_enabled = nil,
            auto_restore_enabled = nil,
            auto_session_suppress_dirs = {
                os.getenv("HOME") -- if neovim is opened from $HOME, then DO NOT restore session
            },
            auto_session_use_git_branch = nil,
            bypass_session_save_file_types = {
                "alpha",
                "noice",
                "notify",
                "blank",
                "NvimTree",
                "",
            }
        }
    },
    {
        -- use telescope to view sessions
        "rmagatti/session-lens",
        -- event = "VeryLazy",
        cmd = { "SessionSave", "SessionDelete", "SessionRestore" },
        opts = {
            path_display = { "shorten" },
            theme_conf = {
                border = false
            },
            previewer = true,
            prompt_title = "Sessions"
        }
    }
}
