-- Use protected call so we know where error is coming from
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine plugin was not found!")
    return
end

-- local diagnostics = {
-- 	"diagnostics",
-- 	sources = { "nvim_diagnostic" },
-- 	sections = { "error", "warn" },
-- 	symbols = { error = " ", warn = " " },
-- 	colored = true,
-- 	update_in_insert = false,
-- 	always_visible = true,
-- }

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diff = {
    "diff",
    colored = true,
    symbols = {
        added = " ",
        modified = " ",
        removed = " "
    },
    cond = hide_in_width
}

local fileformat = {
    "fileformat",
    colored = true,
    -- separator = "|"
}

local filetype = {
    "filetype",
    colored = true,
    icons_enabled = true,
    icon_only = true,
    -- icon = nil,
    -- separator = "|"
}

local location = {
    "location",
    padding = {
        left = 0,
        right = 1
    }
}

local progress = {
    "progress",
    separator = " ",
    padding = {
        left = 1,
        right = 0
    }
}

-- Show current time
local clock = function()
    return " " .. os.date("%R")
end

-- Show hexadecimal value of what is under cursor
local hex = function()
    return "Hex: " .. "0x" .. "%B"
end

-- Shows how many spaces a tab is in current file
local spaces = function()
	return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- Return a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and formatter.nvim
-- local function get_attached_clients()
-- 	local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
-- 	if #buf_clients == 0 then
-- 		return "LSP Inactive"
-- 	end
--
-- 	local buf_ft = vim.bo.filetype
-- 	local buf_client_names = {}
--
-- -- add client
-- for _, client in pairs(buf_clients) do
-- 	if client.name ~= "copilot" and client.name ~= "null-ls" then
-- 		table.insert(buf_client_names, client.name)
-- 	end
-- end
--
-- -- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.
-- -- Add sources (from null-ls)
-- local null_ls_s, null_ls = pcall(require, "none-ls")
-- if null_ls_s then
-- 	local sources = null_ls.get_sources()
-- 	for _, source in ipairs(sources) do
-- 		if source._validated then
-- 			for ft_name, ft_active in pairs(source.filetypes) do
-- 				if ft_name == buf_ft and ft_active then
-- 					table.insert(buf_client_names, source.name)
-- 				end
-- 			end
-- 		end
-- 	end
-- end
--
-- -- Add linters (from nvim-lint)
-- local lint_s, lint = pcall(require, "lint")
-- if lint_s then
-- 	for ft_k, ft_v in pairs(lint.linters_by_ft) do
-- 		if type(ft_v) == "table" then
-- 			for _, linter in ipairs(ft_v) do
-- 				if buf_ft == ft_k then
-- 					table.insert(buf_client_names, linter)
-- 				end
-- 			end
-- 		elseif type(ft_v) == "string" then
-- 			if buf_ft == ft_k then
-- 				table.insert(buf_client_names, ft_v)
-- 			end
-- 		end
-- 	end
-- end
--
-- -- Add formatters (from formatter.nvim)
-- local formatter_s, _ = pcall(require, "formatter")
-- if formatter_s then
-- 	local formatter_util = require("formatter.util")
-- 	for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
-- 		if formatter then
-- 			table.insert(buf_client_names, formatter)
-- 		end
-- 	end
-- end
--
-- -- This needs to be a string only table so we can use concat below
-- 	local unique_client_names = {}
-- 	for _, client_name_target in ipairs(buf_client_names) do
-- 		local is_duplicate = false
-- 		for _, client_name_compare in ipairs(unique_client_names) do
-- 			if client_name_target == client_name_compare then
-- 				is_duplicate = true
-- 			end
-- 		end
-- 		if not is_duplicate then
-- 			table.insert(unique_client_names, client_name_target)
-- 		end
-- 	end
--
-- 	local client_names_str = table.concat(unique_client_names, ", ")
-- 	local language_servers = string.format("[%s]", client_names_str)
--
-- 	return language_servers
-- end

lualine.setup({
    options = {
        globalstatus = true, -- enable to have a single statusline
        icons_enabled = true,
        -- theme = "iceberg_dark", -- "auto" tries to match colorscheme
        theme = "kanagawa",
        component_separators = {
            left = "",
            right = ""
        },
        section_separators = {
            left = "",
            right = ""
        },
        disabled_filetypes = {
            "alpha",
            "dashboard",
            "starter",
            "lazy",
            "mason",
        },
        always_divide_middle = true,
        refresh = {
            statusline = 500,
            tabline = 500,
            winbar = 500,
        },
    },
    sections = {
        lualine_a = {"mode"}, -- can use the `mode` function to get -- <mode> --
        lualine_b = {"branch"},
        lualine_c = {
            diff,
            "diagnostics",
            -- "filename",
            -- Show pending plugin updates
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
            },
            -- Show commands in statusline
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = { fg = "#ff9e64" },
            },
            -- Show recording in statusline
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = { fg = "#ff9e64" },
            },
            {
                function() return "  " .. require("dap").status() end,
                cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                color = { fg = "#ff9e64" },
            },
        },
        lualine_x = {
            -- Show messages in statusline
            -- {
            --     require("noice").api.status.message.get_hl,
            --     cond = require("noice").api.status.message.has,
            -- },
            -- Show commands in statusline
            -- {
            --     require("noice").api.status.command.get,
            --     cond = require("noice").api.status.command.has,
            --     color = { fg = "#ff9e64" },
            -- },
            -- Show recording in statusline
            -- {
            --     require("noice").api.status.mode.get,
            --     cond = require("noice").api.status.mode.has,
            --     color = { fg = "#ff9e64" },
            -- },
            -- Show search count message in statusline
            -- {
            --     require("noice").api.status.search.get,
            --     cond = require("noice").api.status.search.has,
            --     color = { fg = "#ff9e64" },
            -- },
            -- Show what register you are recording too
            -- {
            --     function()
            --         local reg = vim.fn.reg_recording()
            --         if reg ~= "" then reg = "@" .. reg end
            --         return reg
            --     end,
            -- },
            "encoding",
            fileformat,
            filetype,
            "copilot",
            hex,
            spaces,
            -- get_attached_clients,
        },
        lualine_y = {location},
        lualine_z = {progress} -- same goes for progress -- displays % instead of declared function above
        -- lualine_z = {clock}
    },
    -- breadcrumbs plugin does this by default
    -- winbar = {
    --     lualine_c = {
    --         {
    --             function()
    --                 return navic.get_location()
    --             end,
    --             cond = function()
    --                 return navic.is_available()
    --             end
    --         }
    --     }
    -- }
})
