-- Use protected call so we know where error is coming from
local status_ok, cheatsheet = pcall(require, "cheatsheet")
if not status_ok then
	vim.notify("cheatsheet plugin was not found!")
	return
end

cheatsheet.setup({
	bundled_cheatsheets = true,
	bundled_plugin_cheatsheets = true,
	include_only_installed_plugins = true,
	telescope_mappings = {
		['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
		['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
		['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
		['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
	}
})
