-- Print tables
P = function(val)
    print(vim.inspect(val))
    return val
end
-- Reload config
RELOAD = function(...)
    return require("plenary.reload").reload(...)
end
-- Reload config
R = function(name)
    RELOAD(name)
    return require(name)
end
-- Print buffer filetype
B = function()
    return vim.notify(vim.bo.filetype)
end
-- Print server capabilities
-- =vim.lsp.get_client_by_id(4).server_capabilities
-- Keymap declaration
-- nvim -V1 then :verb map
-- S = function()
--     return vim.lsp.get_clients()
-- end
