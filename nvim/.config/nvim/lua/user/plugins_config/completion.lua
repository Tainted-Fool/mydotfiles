-- Use protected call so we know where error is coming from
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	vim.notify("nvim-cmp plugin was not found!")
	return
end
local types = require("cmp.types")
local str = require("cmp.utils.str")

-- Use protected call so we know where error is coming from
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify("cmp_luasnip plugin was not found!")
	return
end

-- Use protected call so we know where error is coming from
local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then
	vim.notify("lspkind plugin was not found!")
	return
end

-- Load snippets from VSCode
require("luasnip.loaders.from_vscode").lazy_load()

-- Completion function when backspace is press
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

lspkind.init({
	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol",

	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = "codicons",

	-- override preset symbols
	--
	-- default: {}
	symbol_map = {
		Text = "󰉿",
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "󰑭",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "󰈇",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "󰙅",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "",
		Copilot = "",
	},
})

cmp.setup({
	-- Completion for luasnip plugin
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	-- Completition key mappings
	mapping = {
		-- ["<C-k>"] = cmp.mapping.select_prev_item(),
		-- ["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-1),
		["<C-f>"] = cmp.mapping.scroll_docs(1),
		["<C-Space>"] = cmp.mapping.complete(),
		-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
		["<C-e>"] = cmp.mapping.close(),

		["<CR>"] = cmp.mapping.confirm({
			select = false,
		}), -- set to false to only confirm explicitly selected items
		-- ["<Right>"] = cmp.mapping.confirm({ select = true }),
		-- ["<C-y>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Insert, -- or Replace
		-- 	select = true, -- accept currently selected item
		-- }),

		-- Tab autocompletion
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--     if cmp.visible() then
		--         cmp.select_next_item()
		--     elseif luasnip.expand_or_jumpable() then
		--         luasnip.expand_or_jump()
		--     elseif check_backspace() then
		--         fallback()
		--     else
		--         fallback()
		--     end
		-- end, {"i", "s"}),

		-- -- Same as TAB but backwards
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		--     if cmp.visible() then
		--         cmp.select_prev_item()
		--     elseif luasnip.jumpable(-1) then
		--         luasnip.jump(-1)
		--     else
		--         fallback()
		--     end
		-- end, {"i", "s"})

		-- Tab autocompletion with copilot
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	local copilot = require("copilot.suggestion")
		-- 	if copilot.is_visible() then
		-- 		copilot.accept()
		-- 	elseif cmp.visible() then
		-- 		local entry = cmp.get_selected_entry()
		-- 		if not entry then
		-- 			cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
		-- 		else
		-- 			cmp.confirm()
		-- 		end
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif check_backspace() then
		-- 		fallback()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {"i", "s"}),

		-- Same as TAB for copilot but backwards
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	local copilot = require("copilot.suggestion")
		-- 	if copilot.is_visible() then
		-- 		copilot.accept()
		-- 	elseif cmp.visible() then
		-- 		local entry = cmp.get_selected_entry()
		-- 		if not entry then
		-- 			cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
		-- 		else
		-- 			cmp.confirm()
		-- 		end
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {"i", "s"}),

		-- Autocompletion choose next menu item
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Autocompletion choose previous menu item
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Autocompletion choose next menu item
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Autocompletion choose previous menu item
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	-- Menu popup configuration
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = {
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
			with_text = true,
			max_width = 50,
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function (entry, vim_item)
				-- get the full snippet and only keep the first line
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)
				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and string.sub(vim_item.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				vim_item.abbr = word
				return vim_item
			end,
			-- menu = {
			-- 	copilot = "[Copilot]",
			-- 	nvim_lsp = "[LSP]",
			-- 	nvim_lua = "[API]",
			-- 	luasnip = "[Snippet]",
			-- 	cmdline = "[Cmdline]",
			-- 	buffer = "[Buffer]",
			-- 	path = "[Path]",
			-- },
		}),
	},

	-- Order of source completion providers
	sources = {
		{
			name = "copilot",
		},
		{
			name = "nvim_lsp",
		},
		{
			name = "nvim_lua",
		},
		{
			name = "luasnip",
		}, -- { name = "cmdline", keyword_length = 3 },
		{
			name = "buffer",
		},
		{
			name = "path",
		},
	},

	-- Comfirmation options
	-- confirm_opts = {
	-- behavior = cmp.ConfirmBehavior.Replace,
	-- select = false,
	-- },

	-- Menu popup customization
	-- window = {
	-- completion = { border = "rounded", scrollbar = false },
	-- we can write it like above or below
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
	-- documentation = { border = "rounded"},
	-- }
	-- },

	-- Cmp features
	experimental = {
		ghost_text = true, -- show ghost text of first item in completion menu
		native_menu = false, -- true is depreciated, use below instead
	},

	-- Different menu, does not have color highlighting
	-- view = {
	-- 	entries = "native",
	-- },
})
