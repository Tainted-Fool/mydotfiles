return {
	settings = {
		Lua = {
			-- Allow LSP server to recognize the "vim" global variable
			diagnostics = {
				globals = { "vim" },
			},
			hint = {
				enable = true,
				arrayIndex = "Disable", -- Auto, Disable, Enable
				await = true,
				paramName = "Disable", -- All, Disable, Literal
				paramType = false,
				semicolon = "Disable", -- All, Disable, SameLine
				setType = true,
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
