return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        local set = vim.keymap.set
        mc.setup()
        -- Add or skip cursor above/below the main cursor
        set({"n", "v"}, "<up>",
            function() mc.lineAddCursor(-1) end, { desc = "Add Cursor Above (multicursor)" })
        set({"n", "v"}, "<down>",
            function() mc.lineAddCursor(1) end, { desc = "Add Cursor Below (multicursor)" })
        set({"n", "v"}, "<leader><up>",
            function() mc.lineSkipCursor(-1) end, { desc = "Skip Cursor Above (multicursor)" })
        set({"n", "v"}, "<leader><down>",
            function() mc.lineSkipCursor(1) end, { desc = "Skip Cursor Below (multicursor)" })
        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "v"}, "<leader>n",
            function() mc.matchAddCursor(1) end, { desc = "Match Add Cursor Below (multicursor)" })
        set({"n", "v"}, "<leader>i",
            function() mc.matchSkipCursor(1) end, { desc = "Match Skip Cursor Below (multicursor)" })
        set({"n", "v"}, "<leader>N",
            function() mc.matchAddCursor(-1) end, { desc = "Match Add Cursor Above (multicursor)" })
        set({"n", "v"}, "<leader>I",
            function() mc.matchSkipCursor(-1) end, { desc = "Match Skip Cursor Above (multicursor)" })
        -- You can also add cursors with any motion you prefer:
        -- set("n", "<right>", function()
        --     mc.addCursor("w")
        -- end)
        -- set("n", "<leader><right>", function()
        --     mc.skipCursor("w")
        -- end)
        -- Rotate the main cursor
        set({"n", "v"}, "<left>", mc.nextCursor, { desc = "Next Cursor (multicursor)" })
        set({"n", "v"}, "<right>", mc.prevCursor, { desc = "Previous Cursor (multicursor)" })
        -- Delete the main cursor
        set({"n", "v"}, "<leader>X", mc.deleteCursor, { desc = "Delete Cursor (multicursor)" })
        -- Add and remove cursors with control + left click
        set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add Cursor with Mouse (multicursor)" })
        -- Easy way to add and remove cursors using the main cursor
        set({"n", "v"}, "<c-q>", mc.toggleCursor, { desc = "Toggle Cursor (multicursor)" })
        -- Clone every cursor and disable the originals
        set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors, { desc = "Deuplicate Cursor (multicursor)" })
        -- Clear all cursors
        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler
            end
        end,
            { desc = "Clear Cursors" })
        -- Align cursor columns
        set("v", "<leader>a", mc.alignCursors, { desc = "Align Cursors (multicursor)" })
        -- Split visual selections by regex
        set("v", "S", mc.splitCursors, { desc = "Split Cursors (multicursor)" })
        -- Append/insert for each line of visual selections
        set("v", "I", mc.insertVisual, { desc = "Insert Cursor (multicursor)" })
        set("v", "A", mc.appendVisual, { desc = "Append Cursor (multicursor)" })
        -- Match new cursors within visual selections by regex
        set("v", "M", mc.matchCursors, { desc = "Match Cursor (multicursor)" })
        -- Rotate visual selection contents
        set("v", "<leader>r",
            function() mc.transposeCursors(1) end, { desc = "Rotate Cursor Below (multicursor)" })
        set("v", "<leader>R",
            function() mc.transposeCursors(-1) end, { desc = "Rotate Cursor Above (multicursor)" })
        -- Customize how cursors look
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
