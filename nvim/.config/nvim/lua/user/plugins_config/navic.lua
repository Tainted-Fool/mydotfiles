-- Use protected call so we know where error is coming from
local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    vim.notify("nvim-navic plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local bread_ok, breadcrumbs = pcall(require, "breadcrumbs")
if not bread_ok then
    vim.notify("breadcrumbs plugin was not found!")
    return
end

navic.setup({
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
})

breadcrumbs.setup()
