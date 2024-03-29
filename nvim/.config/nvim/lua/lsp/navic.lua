return {
    -- show current code context in winbar or statusline
    "SmiteshP/nvim-navic",
    dependencies = {
        -- provides context about your code in winbar
        {
            "LunarVim/breadcrumbs.nvim",
            config = function()
                require("breadcrumbs").setup()
            end
        }
    },
    opts = {
        lsp = {
            auto_attach = true, -- attach to every lsp server
            preference = {"pyright"} -- table ranking lsp servers
        },
        highlight = true,
        click = true,
    },
}
