return {
    -- LSP configuration
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    build = ":MasonUpdate",
    keys = {
        { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LSP Info (nvim-lspconfig)" },
        { "<leader>um","<cmd>Mason<cr>", desc = "LSP Manager (mason)" },
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP completion
        "williamboman/mason.nvim", -- easy install LSP servers
        "williamboman/mason-lspconfig.nvim", -- LSP configurations
        "whoissethdaniel/mason-tool-installer.nvim", -- install and upgrade Mason tools
        "nvimtools/none-ls.nvim", -- diagnostics, code actions, and formatting
        "arkav/lualine-lsp-progress", -- indicator that shows when lsp is ready
        "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas
        { "j-hui/fidget.nvim", opts = {} }, -- show LSP progress handler
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_installer = require("mason-tool-installer")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local icons = require("core.icons")
        -- Declare configurations for diagnostics when LSP is running
        -- vim.diagnostic.enable(false) -- disable diagnostics - on by default
        vim.diagnostic.config({
            virtual_text = false, -- show diagnostic message using virtual text
            virtual_lines = {
                current_line = true, -- show virtual text when your cursor is on line
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
                }
            },
            update_in_insert = false, -- update while editting in insert mode
            underline = true, -- use underline to show diagnostic location
            severity_sort = true, -- order diagnostics by severity
            float = { -- show diagnostics in a floating window
                focusable = true,
                style = "minimal",
                border = "rounded",
                -- source = "always",
                header = "",
                prefix = "",
            }
        })
        -- Declare LSP servers
        local servers = {
            "basedpyright", -- Python (Open-source pyright)
            "bashls",   -- Bash
            "clangd",   -- C
            -- "csharp_ls" -- C Sharp
            "cssls",    -- CSS
            "html",     -- HTML
            "jedi_language_server", -- Python (better docs)
            "jsonls",   -- JSON
            "lua_ls",   -- Lua
            "marksman", -- Markdown
            "omnisharp", -- C Sharp
            "powershell_es", -- PowerShell Editor Services
            -- "pyright",  -- Python (Microsoft)
            -- "pylsp", -- Python (Community)
            -- "sumneko_lua", -- Lua (legacy)
            "ts_ls", -- TypeScript
        }
        -- Accepts Mason and lspconfig package names (dap, format, lint)
        local tools = {
            -- DAP
            "bash-debug-adapter", -- Bash
            "codelldb", -- C, C++
            "debugpy", -- pip install debugpy
            -- "local-lua-debugger-vscode", -- Lua
            "netcoredbg", -- CSharp
            -- Formatter
            "black", -- Python
            "prettier", -- Multiple languages
            "stylua", -- Lua
            -- Linter
            -- "flake8", -- Python (legacy)
            "markdownlint", -- Markdown
            "mypy", -- Python
            "pylint", -- Python
            -- "ruff_lsp", -- Python (legacy)
            "ruff", -- Python
            -- "vulture", -- Python (legacy)
        }
        -- Declare on_attach function - what to do after LSP is attached
        vim.api.nvim_create_autocmd("LSPAttach", {
            group = vim.api.nvim_create_augroup("LSP-Attach", { clear = true }),
            callback = function(event)
                local keymap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc, noremap = true, silent = true })
                end
                local diagnostic_jump = function(count, severity)
                    severity = severity and vim.diagnostic.severity[severity] or nil
                    return function()
                        vim.diagnostic.jump({count = count, severity = severity, float = true})
                    end
                end
                -- Declare keymaps when LSP is running
                -- keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help (lsp)"
                keymap("ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Go to Code Action (lsp)") -- default map to `gra`
                keymap("gd", "<cmd>Telescope lsp_definitions<cr>", "Go to Definition (lsp)")
                keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration (lsp)") -- not supported by all LSPs
                keymap("gf", "<cmd>lua vim.lsp.buf.format()<cr>", "Format Current Buffer (lsp)")
                -- keymap("gh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP Hover (lsp)")
                keymap("gh", function() vim.lsp.buf.hover { border = "rounded" } end, "Show LSP Hover (lsp)")
                keymap("gi", "<cmd>Telescope lsp_implementations<cr>", "Go to Implementation (lsp)") -- not supported by all LSPs
                keymap("gl", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<cr>", "Float Line Diagnostic (lsp)")
                keymap("gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help (lsp)")
                keymap("]d", diagnostic_jump(1, nil), "Next Diagnostic (lsp)")
                keymap("[d", diagnostic_jump(-1, nil), "Prev Diagnostic (lsp)")
                keymap("]e", diagnostic_jump(1, "ERROR"), "Next Error (lsp)")
                keymap("[e", diagnostic_jump(-1, "ERROR"), "Prev Error (lsp)")
                keymap("]w", diagnostic_jump(1, "WARN"), "Next Warning (lsp)")
                keymap("[w", diagnostic_jump(-1, "WARN"), "Prev Warning (lsp)")
                keymap("<leader>uH", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                end, "Disable Endhints/Inlay (lsp)")
                -- Enable inlay hints
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHints) then
                    vim.lsp.inlay_hint.enable()
                    -- vim.notify("Inlay hints enabled for " .. client.name, "info")
                end
                -- Respect server-specific on_attach function
                local require_ok, custom_opts = pcall(require, "lsp.settings." .. client.name)
                if require_ok and custom_opts.on_attach then
                    custom_opts.on_attach(client, event.buf)
                    -- vim.notify("Custom options loaded for LSP server: " .. client.name, "info")
                end
            end
        })
        -- Setup Mason
        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = icons.git.FileStaged,
                    package_pending = icons.misc.Pending,
                    package_uninstalled = icons.git.FileUnstaged,
                }
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        })
        -- Install Mason tools (dap, format, lint)
        mason_installer.setup({
            ensure_installed = tools,
            auto_update = true,
        })
        -- Install and setup LSP servers
        mason_lspconfig.setup({
            ensure_installed = servers,
            automatic_installation = true,
        })
    end
}
