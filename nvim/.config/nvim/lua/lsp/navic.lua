return {
    -- Show current code context in winbar or statusline
    "SmiteshP/nvim-navic",
    dependencies = {
        {
            -- Provides context about your code in winbar
            "Tainted-Fool/breadcrumbs.nvim",
            config = function()
                require("breadcrumbs").setup()
            end
        }
    },
    opts = {
        lsp = {
            auto_attach = true, -- attach to every lsp server
            preference = { "pyright" }, -- table ranking lsp servers
        },
        highlight = true,
        click = true,
    }
}
