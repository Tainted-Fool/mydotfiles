-- Use protected call so we know where error is coming from
-- local status_ok, indent_blankline = pcall(require, "indent_blankline")
local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    vim.notify("indent-blankline plugin was not found!")
    return
end

-- vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
-- vim.g.indent_blankline_filetype_exclude = {
--     "help",
--     "startify",
--     "dashboard",
--     "packer",
--     "neogitstatus",
--     "NvimTree",
--     "Trouble"
-- }

-- vim.g.indentLine_enabled = 1
-- vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = true
-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {
--     "class",
--     "return",
--     "function",
-- 	"method",
-- 	"^if",
-- 	"^while",
-- 	"jsx_element",
-- 	"^for",
-- 	"^object",
-- 	"^table",
-- 	"block",
-- 	"arguments",
-- 	"if_statement",
-- 	"else_clause",
-- 	"jsx_element",
-- 	"jsx_self_closing_element",
-- 	"try_statement",
-- 	"catch_clause",
-- 	"import_statement",
-- 	"operation_type",
-- }

-- vim.wo.colorcolumn = "99999"

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

-- Migrating to V3
ibl.setup()

-- ibl.setup({
--     char = "▏",
--     indent = { char = "▏" },
--     show_trailing_blankline_indent = false,
--     show_first_indent_level = true,
--     use_treesitter = true,
--     show_current_context = true,
--     buftype_exclude = {"terminal", "nofile"},
--     filetype_exclude = {"help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble", "terminal"},
--     char_highlight_list = {"IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3",
--                            "IndentBlanklineIndent4", "IndentBlanklineIndent5", "IndentBlanklineIndent6"}
-- })
