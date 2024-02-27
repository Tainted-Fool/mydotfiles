-- Use protected call so we know where error is coming from
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    vim.notify("none-ls plugin was not found!")
    return
end

-- Declare variables
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- Setup Formatters and Linters
null_ls.setup({
    debug = false,
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
