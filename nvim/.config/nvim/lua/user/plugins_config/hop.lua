-- Use protected call so we know where error is coming from
local status_ok, hop = pcall(require, "hop")
if not status_ok then
    vim.notify("hop plugin was not found!")
end

hop.setup({
    keys = "asdghklqwertyuiopzxcvbnmfj",
    quit_key = "<Esc>",
    perm_method = require("hop.perm").TrieBacktrackFilling,
    reverse_distribution = false,
    teasing = true,
    jump_on_sole_occurrence = true,
    case_insensitive = true,
    create_hl_autocmd = true,
    direction = nil,
    hint_position = require("hop.hint").HintPosition.BEGIN,
    hint_offset = 0,
    current_line_only = false,
    uppercase_labels = false,
    char2_fallback_key = nil,
    extensions = nil,
    multi_windows = false
})

-- Declare variables
local directions = require("hop.hint").HintDirection
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = {
    noremap = true,
    silent = true
}

-- Keymaps
keymap("n", "f", function()
    hop.hint_char1({
        direction = directions.AFTER_CURSOR,
        current_line_only = true
    })
end, opts)
keymap("n", "F", function()
    hop.hint_char1({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true
    })
end, opts)
keymap("n", "t", function()
    hop.hint_char1({
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1
    })
end, opts)
keymap("n", "T", function()
    hop.hint_char1({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1
    })
end, opts)
