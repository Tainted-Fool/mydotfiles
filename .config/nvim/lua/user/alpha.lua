-- Use protected call so we know where error is coming from
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	vim.notify("alpha plugin was not found!")
	return
end

local dashboard = require("alpha.themes.dashboard")
-- Choose a header from below or add a new one
-- dashboard.section.header.val = {
--     [[                       _           ]],
--     [[ _ __   ___  _____   _(_)_ __ ___  ]],
--     [[| '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
--     [[| | | |  __/ (_) \ V /| | | | | | |]],
--     [[|_| |_|\___|\___/ \_/ |_|_| |_| |_|]]
-- }

-- dashboard.section.header.val = {
-- 	[[                               __                ]],
-- 	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
-- 	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
-- 	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
-- 	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
-- 	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }

dashboard.section.header.val = {
	[[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
	[[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
	[[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
	[[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
	[[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
	[[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find File", ":Telescope find_files hidden=true<CR>"),
	dashboard.button("e", " " .. " New File", ":ene <BAR> <CR>"),
	dashboard.button("p", " " .. " Find Project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	dashboard.button("r", " " .. " Recent Files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", " " .. " Find Text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

-- local function footer()
--     return os.date("%m-%d-%Y")
-- end

local function footer()
	-- need fortune-mod -> sudo apt install fortune-mod
	local handle = io.popen("fortune")
	if not handle then
		vim.norify("Fortune-mod not installed")
		vim.notify("Run `sudo apt install fortune-mod`")
		return
	end

	local fortune = handle:read("*a")
	handle:close()
	return fortune
end

dashboard.section.footer.val = footer()
-- dashboard.section.footer.opts.hl = "Type"
dashboard.section.footer.opts.hl = "White"
dashboard.section.header.opts.hl = "Function"
-- dashboard.section.header.opts.hl = "Type"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
