-- Allow LSP server to recognize the "vim" global variable
return {
    settings = {
        lua = {
            diagnostic = {
                globals = {"vim"},
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                }
            }
        }
    }
}