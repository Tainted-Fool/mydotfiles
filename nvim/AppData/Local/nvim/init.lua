-- Init.lua is the entry point for nvim
if (vim.g.vscode) then
    -- VScode Settings
    require("core.vscode")
    vim.keymap.set("n", "[<Space>", "O<Esc>j", { desc = "Create Space Above", noremap = true, silent = true })
    vim.keymap.set("n", "]<Space>", "o<Esc>k", { desc = "Create Space Below", noremap = true, silent = true })
else
    -- Globals
    require("core.globals")
    -- User Settings
    require("core.options")
    require("core.keymaps")
    -- require("core.utils") -- testing
    -- User Autocommands
    require("core.autocommands")
    -- User Plugins Manger
    require("core.lazyman")
end
