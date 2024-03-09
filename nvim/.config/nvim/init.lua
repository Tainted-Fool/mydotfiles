-- Init.lua is the entry point for nvim
if (vim.g.vscode) then
    -- VScode settings
    require("user.vscode")
else
    -- User Settings
    require("user.options")
    require("user.keymaps")

    -- User Autocommands
    require("user.autocommands")

    -- User Plugins
    require("user.plugins")
end
