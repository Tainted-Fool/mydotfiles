-- Declare module
local M = {}

-- Use protected call so we know where error is coming from
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    vim.notify("cmp-nvim-lsp plugin was not found!")
    return
end

--- Add new property to language server (called from configs.lua)
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

-- Declare keymaps when LSP is running
local function lsp_keymaps(bufnr)
    local opts = {
        noremap = true,
        silent = true
    }
    local keymap = vim.api.nvim_buf_set_keymap
    -- local keymap = vim.keymap.set -- does not work with bufnr

    -- Set keymaps for buffers
    keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<cr>", {desc = "Go to definition", noremap = true, silent = true})
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {desc = "Go to declaration", noremap = true, silent = true}) -- not supported by all LSPs
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {desc = "Show LSP hover", noremap = true, silent = true})
    keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", {desc = "Show LSP hover", noremap = true, silent = true})
    keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<cr>", {desc = "Go to implementation", noremap = true, silent = true}) -- not supported by all LSPs
    keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<cr>", {desc = "Go to reference", noremap = true, silent = true})
    keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({border = "rounded"})<cr>', {desc = "Show diagnostic on line", noremap = true, silent = true})
    keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({border = "rounded"})<cr>', {desc = "Go to next diagnostic", noremap = true, silent = true})
    keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({border = "rounded"})<cr>', {desc = "Go to previous diagnostic", noremap = true, silent = true})
    keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {desc = "Show signature help", noremap = true, silent = true})
    keymap(bufnr, "n", "gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {desc = "Show signature help", noremap = true, silent = true})
    keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", {desc = "Rename variable", noremap = true, silent = true})
    keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", {desc = "Go to code action", noremap = true, silent = true})
    keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format()<cr>", {desc = "Format current buffer", noremap = true, silent = true})

    -- Create a 'Format' command for formatting files
    vim.cmd([[command! Format execute 'lua vim.lsp.buf.format{async=true}']])
end

-- Declare LSP signature
local function lsp_signature(bufnr)
    -- Use protected call so we know where error is coming from
    local signature_ok, signature = pcall(require, "lsp_signature")
    if not signature_ok then
        vim.notify("lsp_signature.nvim plugin was not found!")
        return
    end

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
local function lsp_navic(client, bufnr)
    vim.g.navic_silence = false -- supress error messages thrown by nvim-navic

    -- Use protected call so we know where error is coming from
    local navic_status, navic = pcall(require, "nvim-navic")
    if not navic_status then
        vim.notify("nvim-navic plugin was not found!")
        return
    end
    navic.attach(client, bufnr)
end

-- Declare document highlighting
local function lsp_highlight_document(client)
    -- Use protected call so we know where error is coming from
    local illuminate_ok, illuminate = pcall(require, "illuminate")
    if not illuminate_ok then
        vim.notify("vim-illuminate was not found!")
        return
    end
    illuminate.on_attach(client)
end

-- Setup handlers
M.setup = function()
    -- Set diagnostic signs
    local signs = {{
        name = "DiagnosticSignError",
        text = ""
    }, {
            name = "DiagnosticSignWarn",
            text = ""
        }, {
            name = "DiagnosticSignHint",
            text = ""
        }, {
            name = "DiagnosticSignInfo",
            text = ""
        }}

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
end

--- Do things when LSP attaches to buffer (called from configs.lua)
M.on_attach = function(client, bufnr)
    -- Turn off formatting for typescript
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    -- Turn off formatting for lua
    -- if client.name == "sumneko_lua" then
    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    -- Use functions that we declared above
    lsp_keymaps(bufnr)
    lsp_signature(bufnr)
    lsp_navic(client, bufnr)
    lsp_highlight_document(client)

    -- Enable inlay hints
    if client.supports_method("textDocument/inlayHints") then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

return M