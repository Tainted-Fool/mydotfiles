return {
    -- Project manager
    -- "ahmedkhalf/project.nvim", -- not maintained anymore
    "drkjeff16/project.nvim",
    opts = {
        before_attach = nil, -- nil | fun(target_dir: string, method: string)
        on_attach = nil, -- nil | fun(target_dir: string, method: string)
        lsp = {
            enabled = true, --default: true
            ignore = {},
            use_pattern_matching = false, --default: false
            no_fallback = false, --default: false
        },
        manual_mode = false, -- default: false
        patterns = {
            ".git",
            ".github",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "Pipfile",
            "pyproject.toml",
            ".pre-commit-config.yaml",
            ".pre-commit-config.yml",
            ".csproj",
            ".sln",
            ".nvim.lua",
            ".neoconf.json",
            "neoconf.json",
        },
        different_owners = {
            allow = false, -- default: false
            notify = true, -- default: true
        },
        enable_autochdir = false, -- default: false
        show_hidden = true, -- default: false
        exclude_dirs = {},
        silent_chdir = true, --default: true
        scope_chdir = "global", -- global | tab | win
        history = {
            size = 100,
            save_dir = vim.fn.stdpath("data"),
        },
        log = {
            enabled = false, -- default: false
            max_size = 1.1,
            logpath = vim.fn.stdpath("state"),
        },
        snacks = {
            enabled = false, -- default: false
            opts = {
                hidden = false,
                sort = "newest", -- newest | oldest
                title = "Select Project",
                layout = "select",
            }
        },
        fzf_lua = {
            enabled = true, -- default: false
        },
        picker = {
            enabled = false, -- default: false
            hidden = true, --default: false
            sort = "newest", -- newest | oldest
        },
        disable_on = {
            ft = {
                "",
                "NvimTree",
                "TelescopePrompt",
                "TelescopeResults",
                "alpha",
                "checkhealth",
                "lazy",
                "log",
                "ministarter",
                "neo-tree",
                "notify",
                "nvim-pack",
                "packer",
                "qf",
            },
            bt = {
                "help",
                "nofile",
                "nowrite",
                "terminal",
            }
        },
        telescope = {
            sort = "newest", -- newest | oldest
            prefer_file_browser = false, -- default: false
            disable_file_picker = false, -- default: false
            mappings = {
                n = {
                    b = "browse_project_files",
                    d = "delete_project",
                    f = "find_project_files",
                    r = "recent_project_files",
                    s = "search_in_project_files",
                    w = "change_working_directory",
                },
                i = {
                    ["<C-b>"] = "browse_project_files",
                    ["<C-d>"] = "delete_project",
                    ["<C-f>"] = "find_project_files",
                    ["<C-r>"] = "recent_project_files",
                    ["<C-s>"] = "search_in_project_files",
                    ["<C-w>"] = "change_working_directory",
                }
            }
        }
    }
}
