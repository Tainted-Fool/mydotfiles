return {
    -- Run code of any language
    "is0n/jaq-nvim",
    event = "VeryLazy",
    cmd = "Jaq",
    keys = {
        { "<leader>cr", "<cmd>w | Jaq<cr>", desc = "Run (JAQ)" },
    },
    opts = {
        cmds = {
            internal = {
                lua = "luafile %",
                vim = "source %",
            },
            external = {
                markdown = "glow %",
                python = "python3 %",
                go = "go run %",
                sh = "sh %",
                php = "php %",
                c = "gcc % -o $fileBase && ./$fileBase",
                cpp = "g++ % -o $fileBase && ./$fileBase",
                cs = "dotnet run %",
                ps1 = "pwsh %",
            }
        },
        behavior = {
            default = "float", -- can be terminal
            startinsert = false,
            wincmd = false,
            autosave = false,
        },
        ui = {
            float = {
                border = "rounded", -- see ":h nvim_open_win"
                winhl = "Normal", -- see ":h winhl"
                borderhl = "FloatBorder",
                winblend = 0, -- see ":h winblend"
                height = 0.8,
                width = 0.8,
                x = 0.5,
                y = 0.5,
            },
            terminal = {
                position = "bot",
                size = 10,
                line_no = false,
            },
            quickfix = {
                position = "bot",
                size = 10,
            }
        }
    }
}
