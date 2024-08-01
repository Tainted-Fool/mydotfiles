return {
    -- Increment/decrement/interate various elements
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
        local dial_conf = require("dial.config")
        local augend = require("dial.augend")
        local map = require("dial.map")
        local keymap = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
        end

        dial_conf.augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
            },
            visual = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
            },
            mygroup = {
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "&&", "||" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.alias.bool,
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.semver.alias.semver,
                augend.date.alias["%m/%d/%Y"],
            }
        })

        keymap("n", "<C-a>", map.inc_normal("mygroup"), "Increment (dial)")
        keymap("n", "<C-x>", map.dec_normal("mygroup"), "Decrement (dial)")
        keymap("v", "<C-a>", map.inc_normal("visual"), "Increment (dial)")
        keymap("v", "<C-x>", map.dec_normal("visual"), "Decrement (dial)")
    end
}
