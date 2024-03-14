return {
    -- nvim lua API docs and completion
    {
        "folke/neodev.nvim", -- make sure to setup neodev before lspconfig
        enabled = false,
        opts = {},
    },
    {
        -- enable lsp
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {"LspInfo", "LspInstall", "LspUninstall", "Mason" },
        build = ":MasonUpdate",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- lsp completion
            "williamboman/mason.nvim", -- easy install lsp servers
            "williamboman/mason-lspconfig.nvim", -- lsp configurations (done)
            "whoissethdaniel/mason-tool-installer.nvim", -- install and upgrade Mason tools
            "nvimtools/none-ls.nvim", -- diagnostics, code actions, and formatting
            "folke/neodev.nvim", -- better nvim and lsp configuration
            "arkav/lualine-lsp-progress", -- indicator that shows when lsp is ready
            "j-hui/fidget.nvim", -- show lsp progress handler
        },
        config = function()
            -- Declare variables
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_installer = require("mason-tool-installer")

            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local keymap = function(bufnr, keys, func, desc)
                vim.api.nvim_buf_set_keymap(bufnr, "n", keys, func, { desc = desc, noremap = true, silent = true })
            end
            local signature = require("lsp_signature")
            local navic = require("nvim-navic")
            local lspconfig = require("lspconfig")

            -- Default lsp communication capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- extend capabilities with nvim-cmp and luasnip
            capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())

            -- TODO: snippet support is set to false for some reason
            -- capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Declare keymaps when LSP is running
            local lsp_keymaps = function(bufnr)
                keymap(bufnr, "gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
                keymap(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration") -- not supported by all LSPs
                keymap(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP hover")
                keymap(bufnr, "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP hover")
                keymap(bufnr, "gi", "<cmd>Telescope lsp_implementations<cr>", "Go to implementation") -- not supported by all LSPs
                keymap(bufnr, "gr", "<cmd>Telescope lsp_references<cr>", "Go to reference")
                keymap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<cr>", "Show diagnostic on line")
                keymap(bufnr, "]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<cr>", "Go to next diagnostic")
                keymap(bufnr, "[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<cr>", "Go to previous diagnostic")
                -- keymap(bufnr, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help")
                keymap(bufnr, "gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help")
                keymap(bufnr, "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable")
                keymap(bufnr, "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Go to code action")
                keymap(bufnr, "gf", "<cmd>lua vim.lsp.buf.format()<cr>", "Format current buffer")

            end

            -- Declare LSP signature
            local lsp_signature = function(bufnr)
                -- Setup signature configurations
                local signature_cfg = {
                    doc_lines = 0, -- show lines of comment/docs
                    floating_window = false,
                    floating_window_above_cur_line = false,
                    hint_enable = true,
                    hint_prefix = "💀 ",
                    toggle_key = "<C-\\>",
                    select_signature_key = "<C-]>"
                }
                signature.on_attach(signature_cfg, bufnr)
            end

            -- Declare code context
            local lsp_navic = function(client, bufnr)
                vim.g.navic_silence = false -- supress error messages thrown by nvim-navic
                navic.attach(client, bufnr)
            end

            -- -- Set diagnostic signs
            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" }
            }
            -- Define the signs
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, {
                    texthl = sign.name,
                    text = sign.text,
                    numhl = ""
                })
            end

            -- Declare LSP servers
            local servers = {
                "bashls", -- Bash
                "clangd", -- C
                -- "csharp_ls" -- C Sharp
                "cssls", -- CSS
                "html", -- HTML
                -- "jedi_language_server", -- Python
                "jsonls", -- JSON
                "lua_ls", -- Lua
                "marksman", -- Markdown
                "omnisharp", -- C Sharp
                "pyright", -- Python
                -- "sumneko_lua", -- Lua (legacy)
                "tsserver", -- TypeScript
            }

            -- Accepts Mason and lspconfig package names (dap, format, lint)
            local tools = {
                -- DAP
                -- "debugpy",
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

            local mason_opts = {
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4
            }

            -- Setup Mason
            mason.setup(mason_opts)

            -- Install LSP servers
            mason_lspconfig.setup({
                ensure_installed = servers,
                automatic_installation = true
            })

            -- Install Mason tools (dap, format, lint)
            mason_installer.setup({
                ensure_installed = tools,
                auto_update = true
            })

            -- Declare configurations for Diagnostics when LSP is running
            local config = {
                -- Disable virtual text/diagnostic errors
                virtual_text = false, -- enable/disable diagnostic text for plugin trouble
                virtual_lines = {
                    only_current_line = true
                },
                -- virtual_lines = false, -- enable/disable diagnostic for plugin lsp_lines

                -- Show signs
                signs = {
                    active = signs
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true,

                -- Set our popup options for diagnostic errors
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                }
            }
            vim.diagnostic.config(config)

            -- Set popup options for hover window
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded"
                -- width = 60,
            })

            -- Set popup options for signature help window
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded"
                -- width = 60,
            })

            -- Declare on_attach function
            local on_attach = function(client, bufnr)
                lsp_keymaps(bufnr)
                lsp_signature(bufnr)
                lsp_navic(client, bufnr)

                -- Enable inlay hints
                if client.supports_method("textDocument/inlayHints") then
                    vim.lsp.inlay_hint.enable(bufnr, true)
                end

                -- Enable document highlight =vim.lsp.buf_get_clients()[1].server_capabilities
                -- if client.supports_method("textDocument/documentHighlight") then
                --     vim.notify("Document highlight enabled")
                --     vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
                --     vim.cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
                --     vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
                -- end
            end

            -- Go through the lua table as a key-value pair
            for _, server in pairs(servers) do
                local opts = {
                    on_attach = on_attach,
                    capabilities = capabilities
                }

                -- Remove the @<hostname> from the server name
                server = vim.split(server, "@")[1]

                -- Declare variable for LSP server config file to use
                -- conf_opts = require("lsp.setting.<server>")
                local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
                -- If LSP server config file exists, then use those options
                if require_ok then
                    opts = vim.tbl_deep_extend("force", conf_opts, opts)
                end

                -- Setup NeoVim to communicate with LSP servers
                lspconfig[server].setup(opts)
            end

            -- Create a 'Format' command for formatting files
            vim.cmd([[command! Format execute 'lua vim.lsp.buf.format{async=true}']])
        end,
    },
    {
        -- lsp hover documentation in a side panel
        "amrbashir/nvim-docs-view",
        lazy = true,
        cmd = "DocsViewToggle",
        opts = {
            position = "right"
        }
    },
    {
        -- better lsp diagnostics and quickfix list
        "folke/trouble.nvim",
        lazy = true,
        cmd = "TroubleToggle",
        opts = {
            position = "right",
            use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
        }
    },
    {
        -- multiline diagnostics
        "https://github.com/Tainted-Fool/lsp_lines",
        -- opts = {}, -- no options yet...
        config = function()
            require("lsp_lines").setup()
        end
    },
}
