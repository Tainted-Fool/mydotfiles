return {
    -- syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- whenever you install or update through lazy
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- load when file is read or open
    depedencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    --enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not config_ok then
            vim.notify("nvim-treesitter plugin was not found!")
            return
        end

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
                    init_selection = "C-/",
                    node_incremental = "C-/",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
    cmd = { "TSUpdate", "TSUpdateSync", "TSInstall" }, -- load on these commands
    keys = { -- load on these keys
        { "<C-/>", desc = "Incremenet Selection" },
        { "<bs>", desc = "Decrement Selection", mode = "x" },
    }
}
