return {
    -- Markdown viewer
    "oxy2dev/markview.nvim",
    lazy = false,
    -- priority = 49,
    config = function()
        local markview = require("markview")
        local presets = require("markview.presets")
        markview.setup({
            markdown = {
                enable = true,
                block_quotes = {
                    enable = true,
                    wrap = true,
                },
                code_blocks = {
                    enable = true,
                    border_hl = "MarkviewCode",
                    info_hl = "MarkviewCodeInfo",
                    label_direction = "right", -- left | right
                    label_hl = nil,
                    min_width = 60,
                    pad_amount = 2,
                    pad_char = " ",
                    style = "block", -- simple | block
                    sign = true,
                },
                list_items = {
                    enable = true,
                    wrap = true,
                    shift_width = 4,
                },
                headings = presets.headings.marker, -- glow | glow_center | slanted | arrowed | simple | marker
                horizontal_rules = presets.horizontal_rules.arrowed, -- thin | thick | double | dashed | dotted | solid | arrowed
                tables = presets.tables.rounded, -- none | single | double | rounded | solid
            }
        })
    end
}
