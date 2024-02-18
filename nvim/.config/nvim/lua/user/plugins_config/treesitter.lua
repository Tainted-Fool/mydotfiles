-- Use protected call so we know where error is coming from
local config_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not config_ok then
	vim.notify("nvim-treesitter plugin was not found!")
	return
end

-- Setup Language Syntax
treesitter.setup({
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cpp",
		"css",
		"csv",
		"dockerfile",
		"gitignore",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"php",
		"python",
		"regex",
		"rst",
		"ruby",
		"sql",
		"vim",
		"vimdoc",
		"yaml",
	},
	ignore_installed = { "" }, -- list of language syntax to ignore
	sync_install = false,
	auto_install = true, -- auto install language syntax that is not installed
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		-- disable = {"css"} -- list of language syntax to disable
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
		-- disable = { "python" },
	},
	rainbow = {
		enable = true,
		extended_more = true, -- highlight non-bracket delimiters like html tags, boolean or table
	},
	context_commentstring = {
		-- enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		-- disable = { "xml", "markdown" },
	},
	matchup = {
		enable = true,
		-- disable = { "c", "ruby" },
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["a="] = "assignment.outer",
				["i="] = "assignment.inner",
				-- ["h="] = "assignment.lhs",
				-- ["l="] = "assignment.rhs",

				["am"] = "@function.outer",
				["im"] = "@function.inner",

				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				["af"] = "@call.outer",
				["if"] = "@call.inner",

				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",

				["al"] = "loop.outer",
				["il"] = "loop.inner",

				["ai"] = "conditional.outer",
				["ii"] = "conditional.inner",

				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",

				["ab"] = "@block.outer",
				["ib"] = "@block.inner",

				["as"] = "@statement.outer",
				["is"] = "@scopename.inner",

				["aA"] = "@attribute.outer",
				["iA"] = "@attribute.inner",

				["aF"] = "@frame.outer",
				["iF"] = "@frame.inner",
			},
		},
		move = {
			enable = true,
			set_jump = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>."] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>,"] = "@parameter.inner",
			},
		},
		-- does not work use nvim-treesitter-textobjects	instead
		-- incremental_selection = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		init_selection = "<Tab>",
		-- 		node_incremental = "<Tab>",
		-- 		node_decremental = "<S-Tab>",
		-- 		scope_incremental = false,
		-- 	},
		-- },
	},
})
