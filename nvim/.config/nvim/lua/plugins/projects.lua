return {
    -- Project manager
    -- "ahmedkhalf/project.nvim", -- not maintained anymore
    "drkjeff16/project.nvim",
    opts = {
        lsp = {
            enabled = true, --default: true
            ignore = {},
            use_pattern_matching = false, --default: false
            no_fallback = false --default: false
        },
        manual_mode = false,
        enable_autochdir = false, -- default: false
        show_hidden = true, -- default: false
        silent_chdir = true, --default: true
        scope_chdir = "global" -- global | tab | win
    },
}
