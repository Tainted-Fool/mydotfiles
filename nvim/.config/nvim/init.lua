if (vim.g.vscode) then
    require("core.vskeymaps")
    require("core.lazyman")
else
    require("core.globals")
    require("core.options")
    require("core.keymaps")
    -- require("core.utils") -- testing
    require("core.autocommands")
    require("core.lazyman")
end
