-- Use protected call so we know where error is coming from
local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
	vim.notify("harpoon plugin was not found!")
	return
end

local global_settings = {
	-- sets the marks upon calling `toggle` on the ui, instead of require `:w`
	save_on_toggle = false,

	-- saves the harpoon file upon every change. disabling is unrecommended
	save_on_change = true,

	-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`
	enter_on_sendcmd = false,

	-- clsoes any tmux windows harpoon that harpoon creates when you close Nvim
	tmux_autoclose_windows = false,

	-- filetypes that you want to prevent from adding to the harpoon list menu
	excluded_filetypes = { "harpoon" },

	-- set marks specfic to each git branch inside git repository
	mark_branch = false
}

harpoon.setup(global_settings)
