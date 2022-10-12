-- Use protected call so we know where error is coming from
local status_ok, dial_conf = pcall(require, "dial.config")
if not status_ok then
	vim.notify("dial plugin was not found!")
	return
end

-- Declare variables
local augend = require("dial.augend")

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
	},
})

-- Declare variables
local map = require("dial.map")
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Keymaps for NORMAL Mode
keymap("n", "<C-a>", map.inc_normal("mygroup"), opts)
keymap("n", "<C-x>", map.dec_normal("mygroup"), opts)

-- Keymaps for VISUAL Mode
keymap("v", "<C-a>", map.inc_normal("visual"), opts)
keymap("v", "<C-x>", map.dec_normal("visual"), opts)
