-- Use protected call so we know where error is coming from
local status_ok, cheatsheet = pcall(require, "cheatsheet")
if not status_ok then
    vim.notify("cheatsheet plugin was not found!")
    return
end

cheatsheet.setup({
    -- Whether to show bundled cheatsheets
    bundled_cheatsheets = true,
    -- Can be tables like so
    -- bundled_cheatsheets = {
    -- enabled = {"gitsigns.nvim"},
    -- disabled = {"gitsigns.nvim"},
    -- }
    -- For plugin specific cheatsheets
    bundled_plugin_cheatsheets = true,
    -- For bundled plugin cheatsheets
    -- Do not show a sheet if you don't have the plugin installed
    include_only_installed_plugins = true,
    -- Key mapping bound inside the telescope window
    telescope_mappings = {
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet
    }
})
