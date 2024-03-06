return {
    -- increment/decrement/interate various elements
    "monaqa/dial.nvim",
    lazy = true,
    keys = { "<C-a>", "<C-x>" },
    config = function()
        -- Declare variables
        local dial_conf = require("dial.config")
        local augend = require("dial.augend")

        dial_conf.augends:register_group({
            default = {augend.integer.alias.decimal, augend.integer.alias.hex, augend.date.alias["%Y/%m/%d"]},
            visual = {augend.integer.alias.decimal, augend.integer.alias.hex, augend.date.alias["%Y/%m/%d"],
                augend.constant.alias.alpha, augend.constant.alias.Alpha},
            mygroup = {augend.constant.new({
                elements = {"and", "or"},
                word = true,
                cyclic = true
            }), augend.constant.new({
                    elements = {"True", "False"},
                    word = true,
                    cyclic = true
                }), augend.constant.new({
                    elements = {"&&", "||"},
                    word = true,
                    cyclic = true
                }), augend.constant.alias.bool, augend.integer.alias.decimal, augend.integer.alias.hex, augend.semver.alias.semver,
                augend.date.alias["%m/%d/%Y"]}
        })

        -- Declare variables
        local map = require("dial.map")
        local keymap = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
        end

        -- Keymaps for NORMAL Mode
        keymap("n", "<C-a>", map.inc_normal("mygroup"), "Increment")
        keymap("n", "<C-x>", map.dec_normal("mygroup"), "Decrement")

        -- Keymaps for VISUAL Mode
        keymap("v", "<C-a>", map.inc_normal("visual"), "Increment")
        keymap("v", "<C-x>", map.dec_normal("visual"), "Decrement")
    end

}
