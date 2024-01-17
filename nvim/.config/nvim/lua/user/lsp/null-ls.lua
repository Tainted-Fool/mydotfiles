-- Use protected call so we know where error is coming from
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    vim.notify("none-ls plugin was not found!")
    return
end

-- Declare variables
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- Setup linters and formatters
null_ls.setup({
    debug = false,
    sources = {
        -- formatting
        formatting.prettier.with({ -- JavaScript, TypeScript, CSS, HTML, JSON, Markdown formatter
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote"
            }
        }),
        formatting.black.with({ -- Python formatter
            extra_args = {"--fast"}
        }),
        formatting.stylua, -- Lua formatter
        -- linting
        diagnostics.flake8, -- Python linting
        diagnostics.markdownlint -- Markdown linting
    }
})
