return {
    -- Highlights the current scope
    "echasnovski/mini.indentscope",
    opts = {
        symbol = "│",
        options = { try_as_border = true },
    },
    init = function()
        vim.api.nvim_create_autocmd("Filetype", {
            pattern = {
                "help",
                "alpha",
                "Alpha",
                "dashboard",
                "NvimTree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
                "DressingSelect",
                "TelescopePrompt",
                "fzf",
                "fzf-lua",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end
        })
    end
}
