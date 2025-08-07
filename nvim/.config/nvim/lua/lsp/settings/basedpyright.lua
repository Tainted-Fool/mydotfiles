return {
    on_attach = function(client, _)
        client.server_capabilities.hoverProvider = true -- disable hover
    end,
    capabilities = {
        textDocument = {
            publishDiagnostic = {
                tagSupport = {
                    valueSet = { 2 },
                }
            }
        }
    },
    mason = true,
    autostart = true,
    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- using ruff-lsp
            analysis = {
                typeCheckingMode = "standard", -- off | basic | strict | standard
                logLevel = "error", -- debug | info | warn | error
            },
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
