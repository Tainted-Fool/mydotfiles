-- Use protected call so we know where error is coming from
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	vim.notify("comment plugin was not found!")
	return
end

comment.setup({
	-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	pre_hook = function(ctx)
    -- For inlay hints
    local line_start = (ctx.srow or ctx.range.srow) - 1
    local line_end = ctx.erow or ctx.range.erow
    require("lsp-inlayhints.core").clear(0, line_start, line_end)
    require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

		-- Only calculate commentstring for javascript, typescript, and tsx filetypes
		if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
			local U = require("Comment.utils")

      -- Use protected call so we know where error is coming from
      local utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
      if not utils_ok then
        vim.notify("ts_context_commentstring plugin was not found!")
        return
      end

			-- Determine whether to use linewise or blockwise commentstring
			local type = ctx.type == U.ctype.linewise and "__default" or "__multiline"

			-- Determine the location where to calculate commentstring from
			local location = nil
			if ctx.ctype == U.ctype.blockwise then
				location = utils.get_cursor_location()
			elseif ctx.motion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = utils.get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location,
			})
		end
	end,
})
