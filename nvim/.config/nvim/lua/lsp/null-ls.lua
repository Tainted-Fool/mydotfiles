return {
    -- formatters and linters community driven (done)
    "nvimtools/none-ls.nvim",
    config = function()

        -- Declare variables
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        -- Setup Formatters and Linters
        null_ls.setup({
            debug = false,
            border = "rounded", -- rounded, single, double, shadow
            sources = {
                -- Formatters
                formatting.black.with({ -- Python formatter
                    extra_args = {"--fast"}
                }),
                formatting.prettier.with({ -- JavaScript, TypeScript, CSS, HTML, JSON, Markdown formatter
                    extra_args = {
                        "--no-semi",
                        "--single-quote",
                        "--jsx-single-quote"
                    }
                }),
                formatting.stylua, -- Lua formatter
                -- Linters
                diagnostics.markdownlint, -- Markdown linting
                -- diagnostics.flake8, -- Python linting (use ruff lsp)
                diagnostics.mypy, -- Python linting
                diagnostics.pylint, -- Python linting
                -- diagnostics.ruff, -- Python linting (use ruff lsp)
                -- diagnostics.vulture, -- Python linting (use ruff lsp)
            }
        })
    end
}
