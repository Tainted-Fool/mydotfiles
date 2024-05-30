-- Init.lua is the entry point for nvim
if (vim.g.vscode) then
    -- VScode settings
    require("core.vscode")
else
    -- Globals
    require("core.globals")

    -- User Settings
    require("core.options")
    require("core.keymaps")

    -- User Autocommands
    require("core.autocommands")

    -- User Plugins
    require("core.lazy")
end
