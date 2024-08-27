return {
    -- Markdown Table of Contents
    "hedyhli/markdown-toc.nvim",
    ft = "markdown",
    main = "mtoc",
    cmd = "Mtoc",
    keys = {
        { "<leader>ct", "<cmd>Mtoc<CR>", desc = "Insert TOC (mtoc)" },
    },
    opts = {
        headings = {
            -- Insert TOC before first heading
            before_toc = false,-- default:false
            exclude = { "CHANGELOG", "License" },
            pattern = "^(#+)%s+(.+)$",
        },
        fences = {
            enabled = true, -- default:true
            start_text = "mtoc-start",
            end_text = "mtoc-end"
        },
        auto_update = true, -- fences must be enabled
        toc_list = {
            markers = "-",
            cycle_markers = false, -- default:false
            indent_size = 2,
            -- Ensure all heading names are in title case
            item_formatter = function(item, fmtstr)
                local default_formatter = require("mtoc.config").defaults.toc_list.item_formatter
                item.name = item.name:gsub("(%a)([%w_']*)", function(a,b) return a:upper()..b:lower() end)
                return default_formatter(item, fmtstr)
            end
        }
    }
}
