-- Use protected call so we know where error is coming from
local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
	vim.notify("lsp_signature.nvim plugin was not found!")
	return
end

local cfg = {
	debug = false, -- set to true to enabe debug logging
	log_path = "debug_log_file_path", -- debug log path
	verbose = false, -- show debug line number
	bind = true, -- this is mandatory, otherwise border config wont get registered
	doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments to be shown
	-- this setting only takes effect in insert mode, it does not affect signature help in normal mode, 10 by default
	floating_window = false, --show hint in a floating window, set to false for virtual text only mode
	floating_window_above_cur_line = false, -- try to place the floating above the current line when possible
	-- NOTE: will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you DO NOT want the PUM and floating window overlap
	fix_pos = false, -- set to true, the floating window will not auto-close util finish all parameters
	hint_enable = true, -- virtual hint enable
	-- hint_prefix = "🐼 ", -- Panda emoji for parameter
	hint_prefix = "💀 ", -- Skull emoji for parameter
	hint_scheme = "Comment",
	use_lspsaga = false, -- set to true if you want to use lspsaga popup
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating window
	-- if content is more than max height you can scroll down to view the hiding content
	max_width = 120, -- max width of signature floating window, line will be wrapped if exceed max width
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none
	},
	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing
	auto_close_after = nil, -- autoclose signature float window after x seconds
	extra_trigger_char = {}, -- array of extra characters that will trigger signature completion, i.e. {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 to send it to the bottom
	padding = "", -- character to pad on left and right of signature can be ' ', or '|' etc
	transparency = nil, -- disabled by default, allow floating window transparency value 1~100
	shadow_blend = 36, -- if you are using shadow as border, use this to set the opacity
	shadow_guibg = "Black", -- if you are using shadow as border, use this to set the color, i.e. 'Green', or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	-- toggle_key = nil, -- toggle signature on or off in insert mode i.e. '<M-x>'
	-- select_signature_key = nil, -- cycle to next signature, i.e. '<M-n>'
	toggle_key = "<C-\\>",
	select_signature_key = "<C-]>",
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current window and floating
}

-- signature.setup(cfg, bufnr) -- no need to specify bufnr if you DO NOT use toggle key
signature.setup(cfg)
-- signature.on_attach(cfg, bufnr)
