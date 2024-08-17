return {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim" }, -- allow LSP server to recognize the "vim" global variable
            },
            hint = {
                enable = true, --inlayhints
                arrayIndex = "Disable", -- Auto, Disable, Enable
                await = true,
                paramName = "Disable", -- All, Disable, Literal
                paramType = false,
                semicolon = "Disable", -- All, Disable, SameLine
                setType = true,
            },
            workspace = {
                checkThirdParty = false,
                -- library = { vim.env.VIMRUNTIME }, -- use this if slow
                library = {
                    unpack(vim.api.nvim_get_runtime_file('', true))
                }
            }
        }
    }
}
