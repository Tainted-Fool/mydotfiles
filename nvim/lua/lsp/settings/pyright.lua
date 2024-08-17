return {
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false -- disable hover
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
        pyright = {
            disableOrganizeImports = true, -- using ruff-lsp
        },
        python = {
            analysis = {
                ignore = { "*" },
                typeCheckingMode = "off", -- basic, strict, off - using ruff-lsp
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                }
            }
        }
    }
}
