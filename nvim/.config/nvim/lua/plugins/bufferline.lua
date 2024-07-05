return {
    -- Buffer management
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
        { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
        { "]B", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next" },
        { "[B", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
    },
    opts = {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages
            -- style_preset = require("bufferline").style_preset.default,
            themable = true,
            numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = {
                style = "icon", -- "icon" | "underline" | "none"
                icon = "▎",
            },
            buffer_close_icon = require("core.icons").ui.Close,
            modified_icon = require("core.icons").ui.Modified,
            close_icon = require("core.icons").ui.BoldClose,
            left_trunc_marker = require("core.icons").ui.ArrowCircleLeft,
            right_trunc_marker = require("core.icons").ui.ArrowCircleRight,
            max_name_length = 20,
            max_prefix_length = 15,
            tab_size = 15,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left", -- "left" | "center" | "right"
                    separator = true,
                }
            },
            color_icons = true,
            show_buffer_icons = false,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = false,
            duplicates_across_groups = false,
            persist_buffer_sort = false,
            move_wraps_at_ends = false,
            separator_style = "slope", -- "slant" | "slope" | "thick" | "thin"
            enforce_regular_tabs = true,
            always_show_bufferline = false,
            auto_toggle_bufferline = false,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            }
        }
    }
}
