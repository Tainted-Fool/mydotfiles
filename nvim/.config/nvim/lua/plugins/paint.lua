return {
    -- add highlights to buffers
    "folke/paint.nvim",
    ft = "markdown",

    config = function()
        -- Use protected call so we know where error is coming from
        local status_ok, paint = pcall(require, "paint")
        if not status_ok then
            vim.notify("paint plugin was not found!")
            return
        end

        local hlmap = {
            -- patterns :help luaref-pattern
            -- highlights :help highlight
            -- find current highlights `:so $VIMRUNTIME/syntax/hitest.vim`
            -- pattern to highlight or capture group is inside parenthesis
            ["^#%s+(.-)%s*$"] = "Operator",
            ["^##%s+(.-)%s*$"] = "Type",
            ["^###%s+(.-)%s*$"] = "String",
            ["^####%s+(.-)%s*$"] = "Constant",
            ["^#####%s+(.-)%s*$"] = "Number",
            ["^######%s+(.-)%s*$"] = "Error",
            ["`(%w+)`"] = "String",
            ["*(%w+)*"] = "Exception",
            ["%[(%w+)%]"] = "WarningMsg",
            ["%((%w+)%)"] = "DashboardKey",
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
    end,
}
