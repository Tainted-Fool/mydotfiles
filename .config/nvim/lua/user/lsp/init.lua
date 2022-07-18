-- Use protected call so we know where error is coming from
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("nvim-lspconfig plugin was not found!")
    return
end

require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"