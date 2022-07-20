local M = {}

-- Use protected call so we know where error is coming from
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    vim.notify("cmp-nvim-lsp plugin was not found!")
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local function lsp_keymaps(bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap

    -- Set keymaps for buffers
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({border = "rounded"})<cr>', opts)
    keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({border = "rounded"})<cr>', opts)
    keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({border = "rounded"})<cr>', opts)
    keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
    
    -- Create a 'Format' command for formatting files
    vim.cmd([[command! Format execute 'lua vim.lsp.buf.formatting{async=true}']])
end

local function lsp_highlight_document(client)
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        vim.notify("vim-illuminate was not found!")
        return
    end
    illuminate.on_attach(client)
end

M.setup = function()
    -- Set diagnostic signs
    local signs = {
        {name = "DiagnosticSignError", text = ""},
		{name = "DiagnosticSignWarn", text = ""},
		{name = "DiagnosticSignHint", text = ""},
		{name = "DiagnosticSignInfo", text = ""},
    }

    -- Define the signs
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = ""
        })
    end

    local config = {
        -- Disable virtual text/diagnostic errors
        virtual_text = false,

        -- Show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        
        -- Set our popup options for diagnostic errors
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        }
    }

    vim.diagnostic.config(config)

    -- Set our popup options for hover window
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60,
    })

    -- Set our popup options for signature help window
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60,
    })
end

M.on_attach = function(client, bufnr)
    -- Turn off formatting for typescript
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end
    
    -- Set keymaps and document highlights
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    require "lsp_signature".on_attach({
        bind = true,
        floating_window_above_cur_line = false,
        hint_enable = false,
        zindex = 50,
        toggle_key = "<C-\\>",
        select_signature_key = "<C-]>"
    })
end

return M