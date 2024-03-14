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
        icons = {
            File = " ",
            Module = " ",
            Namespace = " ",
            Package = " ",
            Class = " ",
            Method = " ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = "練",
            Interface = "練",
            Function = " ",
            Variable = " ",
            Constant = " ",
            String = " ",
            Number = " ",
            Boolean = "◩ ",
            Array = " ",
            Object = " ",
            Key = " ",
            Null = "ﳠ ",
            EnumMember = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " "
        },
        lsp = {
            auto_attach = true,
            preference = nil
        },
        highlight = true,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        click = true
    }
}
