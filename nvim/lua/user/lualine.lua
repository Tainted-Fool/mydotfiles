-- Use protected call so we know where error is coming from
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
    vim.notify("nvim-navic plugin was not found!")
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

--[[ local diagnostics = { ]]
--[[     "diagnostics", ]]
--[[     sources = {"nvim_diagnostic"}, ]]
--[[     sections = {"error", "warn"}, ]]
--[[     symbols = {error = " ", warn = " "}, ]]
--[[     colored = false, ]]
--[[     update_in_insert = false, ]]
--[[     always_visible = true ]]
--[[ } ]]

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

-- not being used currently
-- local mode = {
--     "mode",
--     fmt = function(str)
--         return "-- " .. str .. " --"
--     end
-- }

local filetype = {
    "filetype",
    colored = true,
    icons_enabled = true,
    icon = nil,
    separator = "|"
}

local fileformat = {
    "fileformat",
    colored = true,
    separator = "|"
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = ""
}

local location = {
    "location",
    padding = 0
}

-- Shows a bar letting us know how far along we are in the current file
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = {"__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██"}
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

-- Shows how many spaces a tab is in current file
local spaces = function()
    return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local hex = function()
    return "Hex: " .. "0x" .. "%B"
end

lualine.setup({
    options = {
        globalstatus = true, -- enable to have a single statusline
        icons_enabled = true,
        theme = "auto",
        component_separators = {
            left = "",
            right = ""
        },
        section_separators = {
            left = "",
            right = ""
        },
        disabled_filetypes = {"alpha", "dashboard", "NvimTree", "Outline"},
        always_divide_middle = true
    },
    sections = {
        lualine_a = {"mode"}, -- can use the `mode` function to get -- <mode> --
        lualine_b = {branch},
        lualine_c = { --[[ diagnostics, ]] --[[ "lsp_progress", ]] {
            function()
                return navic.get_location()
            end,
            cond = navic.is_available
        }},
        lualine_x = {diff, "encoding", fileformat, filetype, hex --[[ spaces ]] },
        lualine_y = {location},
        lualine_z = {"progress"} -- same goes for progress
    }
    --[[ inactive_sections = { ]]
    --[[     lualine_a = {}, ]]
    --[[     lualine_b = {}, ]]
    --[[     lualine_c = {"filename"}, ]]
    --[[     lualine_x = {"location"}, ]]
    --[[     lualine_y = {}, ]]
    --[[     lualine_z = {} ]]
    --[[ }, ]]
    --[[ tabline = {}, ]]
    --[[ extensions = {} ]]
})
