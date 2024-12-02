return {
    -- Markdown viewer
    "oxy2dev/markview.nvim",
    opts = {
        code_blocks = {
            style = "simple", -- simple | minimal | language
            language_direction = "left", -- left | right
            position = "overlay", -- inline | overlay
            pad_char = " ",
            pad_amount = 2,
            hl = "dark",
            min_width = 70,
            sign = true,
        },
        list_items = {
            shift_amount = 2,
        }
    }
}
