-- Use protected call so we know where error is coming from
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	vim.notify("comment plugin was not found!")
	return
end

comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
