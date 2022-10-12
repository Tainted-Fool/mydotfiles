-- Use protected call so we know where error is coming from
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	vim.notify("comment plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
if not utils_ok then
	vim.notify("nvim-ts-context-commentstring plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local internal_ok, internal = pcall(require, "ts_context_commentstring.internal")
if not internal_ok then
	vim.notify("nvim-ts-context-commentstring internals plugin was not found!")
	return
end

comment.setup({
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		-- Determine the location where to calculate commentstring from
		local location = nil
		if ctx.ctype == U.ctype.blockwise then
			location = utils.get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = utils.get_visual_start_location()
		end

		-- Determine whether to use linewise or blockwise commentstring
		local type = ctx.type == U.ctype.linewise and "__default" or "__multiline"
		return internal.calculate_commentstring({
			key = type,
			location = location,
		})
	end,
})
