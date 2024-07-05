return {
    -- Add highlights to buffers
    "folke/paint.nvim",
    enabled = false, -- disable plugin
    -- ft = "markdown",
    config = function()
        local paint = require("paint")
        local hlmap = {
            -- patterns :help luaref-pattern
            -- pattern = "%s*%-%-%-%s*(@w+)" -- @someword
            ["^#%s+(.-)%s*$"] = "Operator", -- # some header
            ["^##%s+(.-)%s*$"] = "Type",
            ["^###%s+(.-)%s*$"] = "String",
            ["^####%s+(.-)%s*$"] = "Constant",
            ["^#####%s+(.-)%s*$"] = "Number",
            ["^######%s+(.-)%s*$"] = "Error",
            -- ["%`([^%`].-)%`"] = "String", -- `some words` (bugged)
            -- ["%*([^%*].-)%*"] = "Exception", -- *some words* (in colorscheme.lua)
            -- ["%[([^%]].-)%]"] = "WarningMsg", -- [some words] (in colorscheme.lua)
            -- ["%(([^%)].-)%)"] = "DashboardKey", -- (some words) (in colorscheme.lua)
        }
        local highlights = {}
        for pattern, hl in pairs(hlmap) do
            table.insert(highlights, {
                filter = { filetype = "markdown" },
                pattern = pattern,
                hl = hl,
            })
        end
        paint.setup({
            --@type PaintHighligh[]
            highlights = highlights,
        })
    end
}
