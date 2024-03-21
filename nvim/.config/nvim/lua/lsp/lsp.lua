return {
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
            { "folke/neodev.nvim", opts = {} }, -- nvim lua API docs and completion
            { "j-hui/fidget.nvim", opts = {} }, -- show lsp progress handler
        },
        config = function()
            -- Declare variables
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_installer = require("mason-tool-installer")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local keymap = function(bufnr, keys, func, desc)
                vim.api.nvim_buf_set_keymap(bufnr, "n", keys, func, { desc = desc, noremap = true, silent = true })
            end

            -- Declare keymaps when LSP is running
            local lsp_keymaps = function(bufnr)
                keymap(bufnr, "gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
                keymap(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration") -- not supported by all LSPs
                -- keymap(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP hover")
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

            -- Declare configurations for Diagnostics when LSP is running
            local config = {
                -- Disable virtual text/diagnostic errors
                virtual_text = false, -- enable/disable diagnostic text for trouble plugin
                virtual_lines = {
                    only_current_line = true
                },

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
            -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            --     border = "rounded"
            --     -- width = 60,
            -- })

            -- Set popup options for signature help window
            -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            --     border = "rounded"
            --     -- width = 60,
            -- })

            -- Declare LSP servers
            local servers = {
                -- "basedpyright", -- Python (Open-source pyright)
                "bashls", -- Bash
                "clangd", -- C
                -- "csharp_ls" -- C Sharp
                "cssls", -- CSS
                "html", -- HTML
                "jedi_language_server", -- Python (better docs)
                "jsonls", -- JSON
                "lua_ls", -- Lua
                "marksman", -- Markdown
                "omnisharp", -- C Sharp
                "pyright", -- Python (Microsoft)
                -- "pylsp", -- Python (Community)
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

            -- Default lsp communication capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- extend capabilities with nvim-cmp
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            -- capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())

            -- Declare on_attach function
            local on_attach = function(client, bufnr)
                lsp_keymaps(bufnr)

                -- Enable inlay hints -- not needed for nvim 0.10+
                if client.supports_method("textDocument/inlayHints") then
                    vim.lsp.inlay_hint.enable(bufnr, true)
                    -- vim.notify("Inlay hints enabled for " .. client.name, "info")
                end
            end

            -- Declare server options
            local server_opts = {
                on_attach = on_attach,
                capabilities = capabilities
            }

            -- Setup Mason
            mason.setup({
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
            })

            -- Install Mason tools (dap, format, lint)
            mason_installer.setup({
                ensure_installed = tools,
                auto_update = true
            })

            -- Install and setup LSP servers
            mason_lspconfig.setup({
                ensure_installed = servers,
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        -- Declare variable for LSP server config file to use
                        -- conf_opts = require("lsp.setting.<server>")
                        local require_ok, conf_opts = pcall(require, "lsp.settings." .. server_name)
                        -- If LSP server config file exists, then use those options
                        if require_ok then
                            server_opts = vim.tbl_deep_extend("force", conf_opts, server_opts)
                            -- vim.notify("LSP server " .. server_name .. " has been installed and configured", "info")
                        end
                        lspconfig[server_name].setup(server_opts)
                    end
                }
            })

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
        enabled = true, -- enable/disable virtual_text
        config = function()
            require("lsp_lines").setup()
        end
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            local util = vim.lsp.util
            local ___ = '\n─────────────────────────────────────────────────────────────────────────────\n'

            local LSPWithDiagSource = {
                name = 'LSP',
                priority = 1000,
                enabled = function()
                    return true
                end,
                execute = function(opts, done)
                    local params = util.make_position_params()
                    vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(responses)
                        local value = ''
                        for _, response in pairs(responses) do
                            local result = response.result
                            if result and result.contents and result.contents.value then
                                if value ~= '' then
                                    value = value .. ___
                                end
                                value = value .. result.contents.value
                            end
                        end

                        local _, row = unpack(vim.fn.getpos('.'))
                        local lineDiag = vim.diagnostic.get(0, { lnum = row - 1 })
                        for _, d in pairs(lineDiag) do
                            if d.message then
                                if value ~= '' then
                                    value = value .. ___
                                end
                                value = value .. string.format('*%s* %s', d.source, d.message)
                            end
                        end
                        value = value:gsub('\r', '')

                        if value ~= '' then
                            done({ lines = vim.split(value, '\n', true), filetype = 'markdown' })
                        else
                            done()
                        end
                    end)
                end,
            }

            local hover = require("hover")
            hover.setup({
                init = function()
                    hover.register(LSPWithDiagSource)
                    require("hover.providers.dictionary")
                end,
                preview_opts = {
                    border = nil,
                },
                preview_window = false,
                title = true,
            })
            vim.keymap.set("n", "K", hover.hover, { desc = "Show hover", noremap = true, silent = true })
            vim.keymap.set("n", "gK", hover.hover_select, { desc = "Show hover select", noremap = true, silent = true })
        end
    }
}
