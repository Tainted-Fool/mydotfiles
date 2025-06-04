return {
    -- Project manager
    -- "ahmedkhalf/project.nvim", -- not maintained anymore
    "drkjeff16/project.nvim",
    event = "VeryLazy",
    opts = {
        active = true,
        on_config_done = nil,
        manual_mode = true,
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
        show_hidden = true,
        silent_chdir = true,
        scope_chdir = "global" -- global | tab | win
    },
    config = function(_, opts)
        require("project_nvim").setup(opts)
        -- Recommended session options configurations
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
        vim.o.autochdir = true -- use current file dir as working dir
    end
}
