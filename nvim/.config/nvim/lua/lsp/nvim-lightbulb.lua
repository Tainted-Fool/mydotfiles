return {
    "kosayoda/nvim-lightbulb",
    enabled = true,
    opts = {
        sign = {
            enabled = true,
            text = require("core.icons").ui.Lightbulb,
            hl = "LightBulbSign",
        },
        virtual_text = {
            enabled = false,
            text = require("core.icons").ui.Lightbulb,
            pos = "eol", -- :h virt_text_win_col & virt_text_pos
            hl = "LightBulbVirtualText",
            hl_mode = "combine",
        },
        float = {
            enabled = false,
            text = require("core.icons").ui.Lightbulb,
            hl = "LightBulbFloatWin",
            win_opts = {
                focusable = false,
            },
        },
        status_text = {
            enabled = false,
            text = require("core.icons").ui.Lightbulb,
            text_unavailable = "",
        },
        number = {
            enabled = false,
            hl = "LightBulbNumber",
        },
        line = {
            enabled = false,
            hl = "LightBulbLine",
        },
        autocmd = {
            enabled = true,
            updatetime = 200,
            events = { "CursorHold", "CursorHoldI" },
            pattern = { "*" },
        },
        ignore = {
            clients = {},
            ft = { "neo-tree" },
            actions_without_kind = false,
        },
    }
}
