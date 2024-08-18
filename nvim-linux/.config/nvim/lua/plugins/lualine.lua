return {
    -- Status bar/line
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "AndreM222/copilot-lualine" }, -- copilot lualine integration
    config = function()
        local icons = require("core.icons")
        -- Show diagnostics
        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "hint", "error", "warn" },
            symbols = {
                hint = icons.diagnostics.Hint .. " ",
                error = icons.diagnostics.Error .. " ",
                warn = icons.diagnostics.Warning .. " ",
            },
            colored = true,
            update_in_insert = true,
            always_visible = false,
        }
        -- Show git information about file
        local diff = {
            "diff",
            colored = true,
            symbols = {
                added = icons.git.LineAdded .. " ",
                modified = icons.git.LineModified .. " ",
                removed = icons.git.LineRemoved .. " ",
            },
            cond = function() return vim.fn.winwidth(0) > 80 end
        }
        -- Show filetype of current file
        local filetype = {
            "filetype",
            icon_only = true,
        }
        -- Show location of cursor as currentline:column
        local location = {
            "location",
            padding = {
                left = 0,
                right = 1,
            }
        }
        -- Show percentage of file scrolled
        local progress = {
            "progress",
            separator = " ",
            padding = {
                left = 1,
                right = 0,
            }
        }
        -- Show pending plugin updates
        local updates = {
            function() return require("lazy.status").updates() end,
            cond = function() return require("lazy.status").has_updates() end,
        }
        -- Show commands you enter
        local commands = {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = { fg = "#ff9e64" },
        }
        -- Show registry of marcro recording
        local recording = {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = { fg = "#ff9e64" },
        }
        -- Show DAP status
        local dap = {
            function() return icons.diagnostics.Debug .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = { fg = "#ff9e64" },
        }
        -- Show hexadecimal value of what is under cursor
        local hex = function()
            return "Hex:0x%B"
        end
        -- Shows how many spaces a tab is in current file
        local spaces = function()
            return "Spaces:" .. vim.api.nvim_get_option_value("shiftwidth", {})
        end
        -- Check for mason package upgrades
        local function mason_updates()
            local registry = require("mason-registry")
            local installed_packages = registry.get_installed_package_names()
            local upgrades_available = false
            local packages_outdated = 0
            local function mycallback(success, _)
                if success then
                    upgrades_available = true
                    packages_outdated = packages_outdated + 1
                end
            end
            for _, pkg in pairs(installed_packages) do
                local p = registry.get_package(pkg)
                if p then
                    p:check_new_version(mycallback)
                end
            end
            if upgrades_available then
                return packages_outdated
            else
                return ""
            end
        end
        -- Show session name
        local session = function()
            return require("auto-session.lib").current_session_name(true)
        end
        -- Show search count message
        -- local count = {
        --     function() return require("noice").api.status.search.get end,
        --     cond = function() return  require("noice").api.status.search.has end,
        --     color = { fg = "#ff9e64" },
        -- }
        -- Show messages
        -- local messages = {
        --     function() return require("noice").api.status.message.get_hl end,
        --     cond = function() return require("noice").api.status.message.has end,
        -- }
        -- Show current time
        -- local clock = function()
        --     return icons.misc.Clock .. " " .. os.date("%R")
        -- end
        require("lualine").setup({
            options = {
                globalstatus = true, -- enable to have a single statusline
                icons_enabled = true,
                theme = "kanagawa", -- "auto" tries to match colorscheme
                -- theme = "iceberg_dark",
                -- theme = "codedark",
                component_separators = {
                    left = "",
                    right = "",
                },
                section_separators = {
                    left = icons.ui.BoldDividerRight,
                    right = icons.ui.BoldDividerLeft,
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
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    diff,
                    diagnostics,
                    dap,
                    commands,
                    recording,
                    updates,
                    {
                        mason_updates,
                        icon = icons.misc.Package,
                        on_click = function()
                            vim.cmd("Mason")
                        end
                    },
                },
                lualine_x = {
                    session,
                    "encoding",
                    "fileformat",
                    -- filetype,
                    "copilot",
                    hex,
                    spaces,
                },
                lualine_y = { location },
                lualine_z = {
                    progress,
                    -- clock,
                }
            }
        })
    end
}
