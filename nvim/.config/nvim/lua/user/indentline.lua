-- Use protected call so we know where error is coming from
local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    vim.notify("indent-blankline plugin was not found!")
    return
end

-- Set tab and space characters
-- vim.cmd([[set list]]) -- boolean value
-- vim.cmd([[set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·]])
-- vim.opt.listchars:append("eol:↴,space:·,tab:→→,trail:↝")

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:·")
vim.opt.listchars:append("tab:·→")
vim.opt.listchars:append("extends:»")
vim.opt.listchars:append("precedes:«")
vim.opt.listchars:append("nbsp:‡")
vim.opt.listchars:append("trail:↝")

-- Highlight order
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

-- Migrating to version 3
ibl.setup()

-- indent_blankline.setup({
-- 	char = "▏",
-- 	use_treesitter = true,
-- 	show_trailing_blankline_indent = false,
-- 	show_first_indent_level = true,
-- 	show_current_context = true,
-- 	buftype_exclude = {
-- 		"terminal",
-- 		"nofile",
-- 	},
-- 	filetype_exclude = {
-- 		"help",
-- 		"packer",
-- 		"NvimTree",
-- 	},
-- 	char_highlight_list = {
-- 		"IndentBlanklineIndent1",
-- 		"IndentBlanklineIndent2",
-- 		"IndentBlanklineIndent3",
-- 		"IndentBlanklineIndent4",
-- 		"IndentBlanklineIndent5",
-- 		"IndentBlanklineIndent6",
-- 	},
-- })
