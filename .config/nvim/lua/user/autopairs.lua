-- Use protected call so we know where error is coming from
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	vim.notify("nvim-autopairs plugin was not found!")
	return
end

npairs.setup({
	check_ts = true, -- treesitting integration
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	-- Disable autopairs for these filetypes
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>", -- Alt+e to move to end
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Use protected call so we know where error is coming from
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("cmp plugin was not found!")
	return
end

-- Add autopairs to atuo-completion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
