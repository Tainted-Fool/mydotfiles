-- Use protected call so we know where error is coming from
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("nvim-lspconfig plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local status_ok, mason = pcall(require, "mason")
if not status_ok then
    vim.notify("mason plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
    vim.notify("mason-lspconfig.nvim plugin was not found!")
    return
end

-- Declare LSP servers to install
local servers = {
    "bashls", -- Bash
    "cssls", -- CSS
    "html", -- HTML
    "jsonls", -- JSON
    "marksman", -- Markdown
    "omnisharp", -- C Sharp
    -- "csharp_ls" -- C Sharp
    -- "pyright", -- Python
    "jedi_language_server", -- Python
    -- "sumneko_lua", -- Lua (legacy)
    "lua_ls", -- Lua
    "tsserver", -- TypeScript
    "clangd" -- C
}

local settings = {
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
mason.setup(settings)

-- Install LSP servers
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true
})

-- Go through the lua table as a key-value pair
for _, server in pairs(servers) do
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    }

    -- Remove the @<hostname> from the server name
    server = vim.split(server, "@")[1]

    -- Declare variable for LSP server config file to use
    -- conf_opts = require("user.lsp.setting.<server>")
    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)

    -- If LSP server config file exists, then use those options
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    -- Setup NeoVim to communicate with LSP servers
    lspconfig[server].setup(opts)
end
