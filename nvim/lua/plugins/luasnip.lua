return {
    -- Snippet engine
    "L3MON4D3/LuaSnip",
    dependencies = {
        { "garymjr/nvim-snippets", opts = { friendly_snippets = true } }, -- snippets for lua
        "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        config = function()
            -- Load snippets from VSCode
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    opts = {
        history = true,
        delete_check_events = "TextChanged",
    },
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
            end,
            expr = true, silent = true, mode = "i",
            desc = "Next snippet",
        },
        { "<c-j>", function() require("luasnip").jump(1) end, mode = "s", desc = "Next snippet" },
        { "<c-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Previous snippet" },
    }
}
