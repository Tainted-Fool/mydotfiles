-- Use protected call so we know where error is coming from
local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
    vim.notify("wilder plugin was not found!")
    return
end

-- Use wilder on these modes
wilder.setup({
    modes = {":", "/", "?"}
})

wilder.set_option("pipeline", {wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline())})

wilder.set_option("renderer", wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
        border = "rounded", -- single, double, rounded, or solid
        max_height = "75%", -- max height of the palette
        min_height = 0, -- set the same as max_height for fixed height
        prompt_position = "top", -- top or bottom
        reverse = 0 -- set to 1 to reverse the order
    })
))
