-- Use protected call so we know where error is coming from
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("lualine plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	vim.notify("nvim-navic plugin was not found!")
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " },
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	colored = true,
	icons_enabled = true,
	icon = nil,
	separator = "|",
}

local fileformat = {
	"fileformat",
	colored = true,
	separator = "|",
}

local location = {
	"location",
	padding = 0,
}

-- Show hexadecimal value of what is under cursor
local hex = function()
	return "Hex: " .. "0x" .. "%B"
end

-- Shows how many spaces a tab is in current file
-- local spaces = function()
-- 	return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

lualine.setup({
	options = {
		globalstatus = true, -- enable to have a single statusline
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" }, -- can use the `mode` function to get -- <mode> --
		lualine_b = { "branch" },
		lualine_c = { diagnostics, navic.get_location },
		lualine_x = { diff, "encoding", fileformat, filetype, hex, --[[ spaces  ]]},
		lualine_y = { location },
		lualine_z = { "progress" }, -- same goes for progress -- displays % instead of declared function above
	},
})
