-- Use protected call so we know where error is coming from
local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	vim.notify("wilder plugin was not found!")
	return
end

wilder.setup({
	modes = {
		":",
		"/",
		"?",
	}
})

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline(),
		wilder.search_pipeline()
	),
})

wilder.set_option("renderer", wilder.wildmenu_renderer({
	highligher = wilder.basic_highlighter(),
}))
