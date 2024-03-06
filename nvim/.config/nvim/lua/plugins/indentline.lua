return {
    -- adds `|` as indentation guides
    "lukas-reineke/indent-blankline.nvim",
    config = function()

        -- Set tab and space characters
        vim.opt.list = true
        vim.opt.listchars:append("eol:↴")
        vim.opt.listchars:append("space:·")
        vim.opt.listchars:append("tab:·→")
        vim.opt.listchars:append("extends:»")
        vim.opt.listchars:append("precedes:«")
        vim.opt.listchars:append("nbsp:‡")
        vim.opt.listchars:append("trail:↝")

        require("ibl").setup()
    end
}
