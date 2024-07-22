return {
    -- LSP configuration
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    build = ":MasonUpdate",
    keys = {
        { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LSP Info (nvim-lspconfig)" },
        { "<leader>um","<cmd>Mason<cr>", desc = "LSP Manager (Mason)" },
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP completion
        "williamboman/mason.nvim", -- easy install LSP servers
        "williamboman/mason-lspconfig.nvim", -- LSP configurations
        "whoissethdaniel/mason-tool-installer.nvim", -- install and upgrade Mason tools
        "nvimtools/none-ls.nvim", -- diagnostics, code actions, and formatting
        "arkav/lualine-lsp-progress", -- indicator that shows when lsp is ready
        "b0o/SchemaStore.nvim", -- access to the SchemaStore catalog - large collection of JSON schemas
        {
            "folke/lazydev.nvim", -- nvim lua API docs and completion
            dependencies = { "Bilal2453/luvit-meta", lazy = true },
            ft = "lua",
            cmd = "LazyDev",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                    { path = "LazyVim", words = { "LazyVim" } },
                    { path = "lazy.nvim", words = { "LazyVim" } },
                }
            }
        },
        { "j-hui/fidget.nvim", opts = {} }, -- show LSP progress handler
        {
            "smjonas/inc-rename.nvim", -- incremental LSP renaming
            event = "VeryLazy",
            keys = {
                { "<leader>cn", ":IncRename ", desc = "Rename (inc-rename)" },
            },
            opts = {},
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_installer = require("mason-tool-installer")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local icons = require("core.icons")
        -- Declare configurations for diagnostics when LSP is running
        vim.diagnostic.config({
            virtual_text = false, -- show diagnostic message using virtual text
            virtual_lines = {
                only_current_line = true, -- show virtual text when your cursor is on line
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
        -- Set popup options for hover window
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
            -- width = 60,
        })
        -- Set popup options for signature help window
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
            -- width = 60,
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
            -- "pyright",  -- Python (Microsoft)
            -- "pylsp", -- Python (Community)
            -- "sumneko_lua", -- Lua (legacy)
            "tsserver", -- TypeScript
        }
        -- Accepts Mason and lspconfig package names (dap, format, lint)
        local tools = {
            -- DAP
            "bash-debug-adapter",
            "codelldb", -- C, C++
            "debugpy", -- pip install debugpy
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
            "ruff-lsp", -- Python
            -- "ruff", -- Python (legacy)
            -- "vulture", -- Python (legacy)
        }
        -- Declare on_attach function
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("Lsp-Attach", { clear = true }),
            callback = function(event)
                local keymap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc, noremap = true, silent = true })
                end
                -- Declare keymaps when LSP is running
                keymap("gd", "<cmd>Telescope lsp_definitions<cr>", "Go to Definition (LSP)")
                keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration (LSP)") -- not supported by all LSPs
                -- keymap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP Hover (LSP)")
                keymap("gh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP Hover (LSP)")
                keymap("gi", "<cmd>Telescope lsp_implementations<cr>", "Go to Implementation (LSP)") -- not supported by all LSPs
                keymap("gl", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<cr>", "Show Diagnostic on Line (LSP)")
                keymap("]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<cr>", "Go to Next Diagnostic (LSP)")
                keymap("[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<cr>", "Go to Previous Diagnostic (LSP)")
                -- keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help (LSP)")
                keymap("gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help (LSP)")
                keymap("ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Go to Code Action (LSP)")
                keymap("gf", "<cmd>lua vim.lsp.buf.format()<cr>", "Format Current Buffer (LSP)")
            end
        })
        -- Default LSP communication capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            }
        }
        -- Enable folding by LSP on line :350
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        -- Extend capabilities with nvim-cmp
        -- capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
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
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = function(client, _)
                            -- Enable inlay hints
                            if client.server_capabilities.inlayHintProvider then
                                vim.lsp.inlay_hint.enable = true
                            end
                        end,
                        capabilities = capabilities,
                    })
                    -- If LSP server config file exists, then use those options
                    local require_ok, conf_opts = pcall(require, "lsp.settings." .. server_name)
                    if require_ok then
                        local server_opts = vim.tbl_deep_extend("force", conf_opts, capabilities)
                        lspconfig[server_name].setup(server_opts)
                        -- vim.notify("LSP server " .. server_name .. " has been installed and configured", "info")
                    end
                end
            }
        })
    end
}
