return {
    -- Syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" }, -- see context in winbar
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- load when file is read or open
    build = ":TSUpdate", -- whenever you install or update through lazy
    cmd = { "TSUpdate", "TSUpdateSync", "TSInstall" }, -- load on these commands
    keys = {
        { "v", desc = "Incremenet Selection (treesitter)", mode = "x" },
        { "V", desc = "Decrement Selection (treesitter)", mode = "x" },
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "bash",
                "c",
                "c_sharp",
                "cpp",
                "css",
                "csv",
                "dockerfile",
                "gitignore",
                "go",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "php",
                "powershell",
                "python",
                "regex",
                "rst",
                "ruby",
                "sql",
                "vim",
                "vimdoc",
                "yaml",
            },
            ignore_installed = { "" }, -- list of language syntax to ignore
            sync_install = false,
            auto_install = true, -- auto install language syntax that is not installed
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                -- disable = {"css"} -- list of language syntax to disable
            },
            indent = {
                enable = true,
                -- disable = { "python" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- init_selection = "<CR>", -- bug with `q:`
                    -- scope_incremental = "<CR>",
                    node_incremental = "v",
                    node_decremental = "V",
                }
            }
        })
    end
}
