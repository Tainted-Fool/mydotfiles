-- Use protected call so we know where error is coming from
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("nvim-treesitter plugin was not found!")
    return
end

treesitter.setup({
    ensure_installed = "all", -- list of language syntax to install
    ignore_installed = {""},  -- list of language syntax to ignore
    highlight = {
        enable = true,
        disable = {"css"}     -- list of language syntax to disable
    },
    autopairs = {
        enable = true
    },
    indent = {
        enable = true,
        disable = {"css"}
    }
})