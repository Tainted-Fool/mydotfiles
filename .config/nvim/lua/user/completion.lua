-- Use protected call so we know where error is coming from
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	vim.notify("nvim-cmp plugin was not found!")
	return
end

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
require("luasnip/loaders/from_vscode").lazy_load()

-- Completion function when backspace is press
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

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

		["<CR>"] = cmp.mapping.confirm({ select = false }), -- set to false to only confirm explicitly selected items
		-- ["<Right>"] = cmp.mapping.confirm({ select = true }),
		-- ["<C-y>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Insert,
		-- 	select = true, -- accept currently selected item
		-- }),

		-- Tab autocompletion
		["<Tab>"] = cmp.mapping(function(fallback)
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

		-- Same as TAB but backwards
		["<S-Tab>"] = cmp.mapping(function(fallback)
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
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[API]",
				luasnip = "[Snippet]",
				cmdline = "[Cmdline]",
				buffer = "[Buffer]",
				path = "[Path]",
			},
		}),
	},

	-- Order of source completion providers
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		-- { name = "cmdline", keyword_length = 3 },
		{ name = "buffer" },
		{ name = "path" },
	},

	-- Comfirmation options
	-- confirm_opts = {
	-- behavior = cmp.ConfirmBehavior.Replace,
	-- select = false,
	-- },

	-- Menu popup customization
	-- window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
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
