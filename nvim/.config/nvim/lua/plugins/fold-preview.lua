return {
    -- Fold preview with `l` and `h`
    "tainted-fool/fold-preview.nvim",
    enabled = false,
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
        local fp = require("fold-preview")
        local map = fp.mapping
        local keymap = vim.keymap
        keymap.amend = require("keymap-amend")

        fp.setup({
            default_keybindings = false
        })

        -- Setup keybind for `K`
        keymap.amend("n", "K", function(original)
        if not fp.show_preview() then original() end
        end)
    end
}
