return {
    on_attach = function(client, bufnr)
        client.server_capabilities.rename = false -- disable rename
        client.server_capabilities.renameProvider = false -- disable rename provider
    end,
    mason = true,
    autostart = true,
    settings = {},
}
