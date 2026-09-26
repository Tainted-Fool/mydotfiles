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
                -- block_quotes = {
                --     enable = true,
                --     wrap = true,
                --     default = {
                --         border = "▋",
                --         hl = "MarkviewBlockQuoteDefault"
                --     },
                -- },
                code_blocks = {
                    enable = true,
                    border_hl = "MarkviewCode",
                    info_hl = "MarkviewCodeInfo",
                    label_direction = "right", -- left | right
                    label_hl = nil,
                    min_width = 60,
                    pad_amount = 2,
                    pad_char = " ",
                    default = {
                        block_hl = "MarkviewCode",
                        pad_hl = "MarkviewCode"
                    },
                    ["diff"] = {
                        block_hl = function (_, line)
                            if line:match("^%+") then
                                return "MarkviewPalette4";
                            elseif line:match("^%-") then
                                return "MarkviewPalette1";
                            else
                                return "MarkviewCode";
                            end
                        end,
                        pad_hl = "MarkviewCode"
                    },
                    style = function (buf)
                        if vim.o.wrap then
                            return "simple";
                        end
                        local win = require("markview.utils").buf_getwin(buf);
                        return vim.wo[win].wrap == true and "simple" or "block";
                    end,
                    sign = true,
                },
                list_items = {
                    enable = true,
                    wrap = true,
                    indent_size = function (buffer)
                        if type(buffer) ~= "number" then
                            return vim.bo.shiftwidth or 4;
                        end
                        --- Use 'shiftwidth' value.
                        return vim.bo[buffer].shiftwidth or 4;
                    end,
                    shift_width = 4,
                    marker_minus = {
                        add_padding = true,
                        conceal_on_checkboxes = true,
                        text = "●",
                        hl = "MarkviewListItemMinus"
                    },
                    marker_plus = {
                        add_padding = true,
                        conceal_on_checkboxes = true,
                        text = "◈",
                        hl = "MarkviewListItemPlus"
                    },
                    marker_star = {
                        add_padding = true,
                        conceal_on_checkboxes = true,
                        text = "◇",
                        hl = "MarkviewListItemStar"
                    },
                    marker_dot = {
                        text = function (_, item)
                            return string.format("%d.", item.n);
                        end,
                        hl = "@markup.list.markdown",
                        add_padding = true,
                        conceal_on_checkboxes = true
                    },
                    marker_parenthesis = {
                        text = function (_, item)
                            return string.format("%d)", item.n);
                        end,
                        hl = "@markup.list.markdown",
                        add_padding = true,
                        conceal_on_checkboxes = true
                    }
                },
                headings = presets.headings.marker, -- glow | glow_center | slanted | arrowed | simple | marker
                horizontal_rules = presets.horizontal_rules.arrowed, -- thin | thick | double | dashed | dotted | solid | arrowed
                tables = presets.tables.rounded, -- none | single | double | rounded | solid
                -- block_quotes = presets.block_quotes.obsidian,
                metadata_minus = {
                    enable = true,
                    hl = "MarkviewCode",
                    border_hl = "MarkviewCodeFg",
                    border_top = "▄",
                    border_bottom = "▀"
                },
                metadata_plus = {
                    enable = true,
                    hl = "MarkviewCode",
                    border_hl = "MarkviewCodeFg",
                    border_top = "▄",
                    border_bottom = "▀"
                },
                reference_definitions = {
                    enable = true,
                    default = {
                        icon = " ",
                        hl = "MarkviewPalette4Fg"
                    },
                },
            }
        })
    end
}
