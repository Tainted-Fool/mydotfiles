-- Use protected call so we know where error is coming from
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    vim.notify("nvim-lsp-installer plugin was not found!")
    return
end

local lspconfig = require("lspconfig")

-- Declare LSP servers to install
local servers = {"omnisharp", "pyright", "jsonls", "sumneko_lua", "tsserver"}

lsp_installer.setup({
    ensure_installed = servers,
})

-- Go through the lua table as a key value pair
for _, server in pairs(servers) do
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    -- Declare LSP server config file to use
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

    -- If LSP server config file exists, then use those options
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    lspconfig[server].setup(opts)
end