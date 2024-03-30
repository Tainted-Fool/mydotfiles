return {
    {
        -- enable lsp
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
        build = ":MasonUpdate",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",             -- lsp completion
            "williamboman/mason.nvim",          -- easy install lsp servers
            "williamboman/mason-lspconfig.nvim", -- lsp configurations (done)
            "whoissethdaniel/mason-tool-installer.nvim", -- install and upgrade Mason tools
            "nvimtools/none-ls.nvim",           -- diagnostics, code actions, and formatting
            "folke/neodev.nvim",                -- better nvim and lsp configuration
            "arkav/lualine-lsp-progress",       -- indicator that shows when lsp is ready
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

            -- -- Declare diagnostic signs
            local signs = {
                { name = "DiagnosticSignError", text = "" }, -- ✘
                { name = "DiagnosticSignWarn", text = "" }, -- ▲
                { name = "DiagnosticSignHint", text = "" }, -- ⚑
                { name = "DiagnosticSignInfo", text = "" }, -- »
            }
            -- Set the signs
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, {
                    texthl = sign.name,
                    text = sign.text,
                    numhl = "",
                })
            end

            -- Declare configurations for diagnostics when LSP is running
            local config = {
                -- Disable virtual text/diagnostic errors
                virtual_text = false, -- show diagnostic message using virtual text
                virtual_lines = {
                    only_current_line = true, -- show virtual text when your cursor is in line
                },
                signs = {
                    active = signs, -- set signs to the above configuration
                },
                update_in_insert = false, -- update while editting in insert mode
                underline = true, -- use underline to show diagnostic location
                severity_sort = true, -- order diagnostics by severity
                float = { -- show diagnostics in a floating window
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
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

            -- Declare on_attach function
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("Lsp-Attach", { clear = true }),
                callback = function(event)
                    local keymap = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc, noremap = true, silent = true })
                    end

                    -- Declare keymaps when LSP is running
                    keymap("gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
                    keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration") -- not supported by all LSPs
                    -- keymap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP hover")
                    keymap("gh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show LSP hover")
                    keymap("gi", "<cmd>Telescope lsp_implementations<cr>", "Go to implementation") -- not supported by all LSPs
                    keymap("gr", "<cmd>Telescope lsp_references<cr>", "Go to reference")
                    keymap("gl", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<cr>", "Show diagnostic on line")
                    keymap("]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<cr>", "Go to next diagnostic")
                    keymap("[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<cr>", "Go to previous diagnostic")
                    -- keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help")
                    keymap("gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help")
                    keymap("gn", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable")
                    keymap("ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Go to code action")
                    keymap("gf", "<cmd>lua vim.lsp.buf.format()<cr>", "Format current buffer")
                end,
            })

            -- Disable diagnostics in insert mode
            vim.api.nvim_create_autocmd('ModeChanged', {
                pattern = {'n:i', 'v:s'},
                desc = 'Disable diagnostics in insert and select mode',
                callback = function(e) vim.diagnostic.disable(e.buf) end
            })

            vim.api.nvim_create_autocmd('ModeChanged', {
                pattern = 'i:n',
                desc = 'Enable diagnostics when leaving insert mode',
                callback = function(e) vim.diagnostic.enable(e.buf) end
            })

            -- Default lsp communication capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            }
            -- enable folding by lsp :398
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            -- extend capabilities with nvim-cmp
            -- capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

            -- Setup Mason
            mason.setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
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
                            on_attach = function(client, bufnr)
                                -- Enable inlay hints
                                if client.supports_method("textDocument/inlayHints") then
                                    vim.lsp.inlay_hint.enable(bufnr, true)
                                    -- vim.notify("Inlay hints enabled for " .. client.name, "info")
                                end
                            end,
                            capabilities = capabilities,
                        })

                        -- If LSP server config file exists, then use those options
                        -- conf_opts = require("lsp.setting.<server>")
                        local require_ok, conf_opts = pcall(require, "lsp.settings." .. server_name)
                        if require_ok then
                            local server_opts = vim.tbl_deep_extend("force", conf_opts, capabilities)
                            lspconfig[server_name].setup(server_opts)
                            -- vim.notify("LSP server " .. server_name .. " has been installed and configured", "info")
                        end
                    end,
                },
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
            position = "right",
        },
    },
    {
        -- better lsp diagnostics and quickfix list
        "folke/trouble.nvim",
        lazy = true,
        cmd = "TroubleToggle",
        opts = {
            position = "right",
            use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
        },
    },
    {
        -- multiline diagnostics
        "https://github.com/Tainted-Fool/lsp_lines",
        -- opts = {}, -- no options yet...
        -- enabled = true, -- enable/disable virtual_text
        event = "LspAttach",
        config = function()
            require("lsp_lines").setup()
        end,
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            local util = vim.lsp.util
            local ___ =
            "\n─────────────────────────────────────────────────────────────────────────────\n"

            local LSPWithDiagSource = {
                name = "LSP",
                priority = 1000,
                enabled = function()
                    return true
                end,
                execute = function(_, done)
                    local params = util.make_position_params()
                    vim.lsp.buf_request_all(0, "textDocument/hover", params, function(responses)
                        local value = ""
                        for _, response in pairs(responses) do
                            local result = response.result
                            if result and result.contents and result.contents.value then
                                if value ~= "" then
                                    value = value .. ___
                                end
                                value = value .. result.contents.value
                            end
                        end

                        local _, row = unpack(vim.fn.getpos("."))
                        local lineDiag = vim.diagnostic.get(0, { lnum = row - 1 })
                        for _, d in pairs(lineDiag) do
                            if d.message then
                                if value ~= "" then
                                    value = value .. ___
                                end
                                value = value .. string.format("*%s* %s", d.source, d.message)
                            end
                        end
                        value = value:gsub("\r", "")

                        if value ~= "" then
                            done({ lines = vim.split(value, "\n"), filetype = "markdown" })
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
                    border = "rounded", -- rounded, single, double, shadow
                },
                preview_window = false,
                title = true,
            })
            vim.keymap.set("n", "K", hover.hover, { desc = "Show hover", noremap = true, silent = true })
            vim.keymap.set("n", "gK", hover.hover_select, { desc = "Show hover select", noremap = true, silent = true })
        end,
    },
    {
        -- better fold
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        dependencies = {
            "masukomi/vim-markdown-folding",
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        bt_ignore = { "dashboard", "NvimTree", "Lazy" },
                        segments = {
                            { text = { "%s" }, click = "v:lua.ScSa" }, -- gitsigns (moves diagnostic too)
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- line number
                            { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- fold icons
                        },
                    })
                end,
            },
        },
        config = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.g.markdown_folding = true
            vim.g.markdown_fold_style = "nested"
            -- vim.o.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
            -- vim.o.statuscolumn = "%=%l%s%C"

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local totalLines = vim.api.nvim_buf_line_count(0)
                local foldedLines = endLnum - lnum
                local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
                suffix = (" "):rep(rAlignAppndx) .. suffix
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end

            vim.keymap.set("n", "zR", "<cmd>lua require('ufo').openAllFolds()<CR>", { desc = "Open all folds" })
            vim.keymap.set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", { desc = "Close all folds" })
            vim.keymap.set("n", "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", { desc = "Open less folds" })

            require("ufo").setup({
                -- uncomment to use treesitter as fold provider or defaults to nvim lsp :156
                -- provider_selection = function()
                --     return { "treesitter", "indent" }
                -- end,
                open_fold_hl_timeout = 400,
                close_fold_kinds_for_ft = {},
                fold_virt_text_handler = handler,
                enable_get_fold_virt_text = true,
                preview = {
                    win_config = {
                        border = "rounded",
                        winblend = 0,
                    },
                },
            })
        end,
    },
    {
        -- fold preview
        "anuvyklack/fold-preview.nvim",
        dependencies = "anuvyklack/keymap-amend.nvim",
        enabled = false,
        opts = {},
    },
}
