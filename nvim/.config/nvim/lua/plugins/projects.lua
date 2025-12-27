return {
    -- Project manager
    -- "ahmedkhalf/project.nvim", -- not maintained anymore
    "drkjeff16/project.nvim",
    opts = {
        use_lsp = true,
        manual_mode = false,
        enable_autochdir = false, -- default: false
        show_hidden = true, -- default: false
        silent_chdir = true, --default: true
        scope_chdir = "global" -- global | tab | win
    },
}
