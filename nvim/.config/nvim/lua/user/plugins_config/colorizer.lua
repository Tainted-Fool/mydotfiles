-- Use protected call so we know where error is coming from
local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
    vim.notify("colorizer plugin was not found!")
end

colorizer.setup({
    filetypes = {"*"},
    user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- name codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- enable all CSS features
        css_fn = false, -- enable all CSS functions
        mode = "background", -- set the display mode (foreground,background,virtualtext)
        tailwind = false, -- enable tailwind colors (true,false,"normal","lsp","both")
        sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false
    }
})
