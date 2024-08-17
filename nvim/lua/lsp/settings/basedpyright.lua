return {
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false -- disable hover
    end,
    capabilities = {
        textDocument = {
            publishDiagnostic = {
                tagSupport = {
                    valueSet = { 2 }
                }
            }
        }
    },
    mason = true,
    autostart = true,
    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- using ruff-lsp
            typeCheckingMode = "standard",
        },
        -- python = {
        --     analysis = {
        --         ignore = { "*" },
        --         typeCheckingMode = "off", -- basic, strict, off - using ruff-lsp
        --         inlayHints = {
        --             variableTypes = true,
        --             functionReturnTypes = true
        --         }
        --     }
        -- }
    }
}
