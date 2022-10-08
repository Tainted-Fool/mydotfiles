-- Use protected call so we know where error is coming from
local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
	vim.notify("nvim-treesitter plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local config_ok, configs = pcall(require, "nvim-treesitter.configs")
if not config_ok then
	vim.notify("nvim-treesitter-configs plugin was not found!")
	return
end

configs.setup({
	ensure_installed = "all", -- list of language syntax to install
	ignore_installed = { "" }, -- list of language syntax to ignore
	sync_install = false,
	highlight = {
		enable = true,
		-- disable = {"css"}     -- list of language syntax to disable
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
		-- disable = {"css"}
	},
	rainbow = {
		enable = true,
		extended_more = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
