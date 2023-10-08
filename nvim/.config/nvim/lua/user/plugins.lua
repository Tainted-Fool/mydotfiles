-- Declare variable
local fn = vim.fn

-- Automatically install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that runs 'PackerSync' whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use protected call so we know where error is coming from
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("packer plugin was not found!")
	return
end

-- Have Packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins here
return packer.startup(function(use)
	-- Speed up Loading
	use("lewis6991/impatient.nvim") -- speed up loading lua modules

	-- Startuptime Breakdown
	use("dstein64/vim-startuptime") -- :Startuptime or nvim --startuptime

	-- Packer
	use("wbthomason/packer.nvim") -- plugin manager

	-- Colorschemes
	use("rafi/awesome-vim-colorschemes")
	use("folke/tokyonight.nvim")

	-- Autocompletion
	use("hrsh7th/nvim-cmp") -- the auto completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completion
	use("hrsh7th/cmp-cmdline") -- cmdline completion
	use("hrsh7th/cmp-path") -- path completion
	use("hrsh7th/cmp-nvim-lsp") -- lsp completion
	use("hrsh7th/cmp-nvim-lua") -- lua completion
	use("saadparwaiz1/cmp_luasnip") -- snippet completion

	-- Snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable lsp
	use("williamboman/mason.nvim") -- easy install lsp servers
	use("williamboman/mason-lspconfig.nvim") -- lsp configurations
	use("jose-elias-alvarez/null-ls.nvim") -- formatting and linters
	use("RRethy/vim-illuminate") -- highlight same symbols under cursor
	use("arkav/lualine-lsp-progress") -- indicator that shows when lsp is ready
	use("ray-x/lsp_signature.nvim") -- better signature help
	use("lvimuser/lsp-inlayhints.nvim") -- shows data type for certain languages
	use("b0o/SchemaStore.nvim") -- access to the SchemaStore catalog - large collection of JSON schemas
	use("SmiteshP/nvim-navic") -- show current code context in winbar or statusline
	use("simrat39/symbols-outline.nvim") -- show document symbols in right window
	use({"j-hui/fidget.nvim", tag = "legacy"}) -- show lsp progress handler
	use("folke/trouble.nvim") -- better lsp diagnostics and quickfix list
	use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- multiline diagnostics
	use("onsails/lspkind.nvim") -- lsp completion icons
	use("amrbashir/nvim-docs-view") -- lsp hover documentation in a side panel
	-- use("vonheikemen/lsp-zero.nvim") -- zero lsp configurations
	-- use("decodetalkers/csharpls-extended-lsp.nvim") -- csharp_ls extended

	-- LUA
	use("nvim-lua/plenary.nvim") -- useful lua functions
	use("nvim-lua/popup.nvim") -- useful lua functions
	use("folke/lua-dev.nvim") -- nvim lua API docs and completion
	use("rcarriga/nvim-notify") -- better notifications
	use("stevearc/dressing.nvim") -- UI hook for vim.ui.select/input
	use("antoinemadec/FixCursorHold.nvim") -- fix cursor hold
	use("MunifTanjim/nui.nvim") -- UI component library for nvim

	-- Fuzzy Search
	use("nvim-telescope/telescope.nvim") -- find files
	use("nvim-telescope/telescope-file-browser.nvim") -- preview of file
	use("ibhagwan/fzf-lua") -- fzf made in lua

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter") -- syntax highlighting
	use("nvim-treesitter/nvim-treesitter-textobjects") -- syntax aware text-objects
	use("p00f/nvim-ts-rainbow") -- rainbow pairs for treesitter
	use("windwp/nvim-ts-autotag") -- autoclose/autorename html tags
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("vimjas/vim-python-pep8-indent") -- Fix treesitter auto-indent for python

	-- QOL
	use("kylechui/nvim-surround") -- add/change/delete surrounding pairs
	use("windwp/nvim-autopairs") -- auto pairs
	use("numToStr/Comment.nvim") -- comment/uncomment
	use("lukas-reineke/indent-blankline.nvim") -- adds `|` as indentation guides
	use("karb94/neoscroll.nvim") -- better scrolling
	use("tpope/vim-fugitive") -- git wrapper :Git <tab>
	use("tpope/vim-repeat") -- repeat last command
	use("tpope/vim-unimpaired") -- useful mappings like ]space and ]b
	use("tpope/vim-abolish") -- convert words to camel, mix, with 'crc'
	use("tpope/vim-sleuth") -- Automatically adjusts 'shiftwidth' and 'expandtab'
	use("justinmk/vim-sneak") -- faster motion with 's'
	-- use("easymotion/vim-easymotion") -- faster motion with dash '-' '<motion>'
	use("phaazon/hop.nvim") -- better navigation with f and t
	use("NvChad/nvim-colorizer.lua") -- displays the hexvalue color
	use("monaqa/dial.nvim") -- increment/decrement/interate various elements
	use("andymass/vim-matchup") -- better % navigate and highlight matching words
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	})
	use("abecodes/tabout.nvim") -- use tab to exit quotation marks and other characters
	use("ThePrimeagen/harpoon") -- mark and get file
	use("folke/noice.nvim") -- replace UI for messages, cmdline, and popupmenu
	use("gelguy/wilder.nvim") -- adds new features and capabilities to wildmenu
	use("EtiamNullam/deferred-clipboard.nvim") -- use system clipboard
	use("sudormrfbin/cheatsheet.nvim") -- cheatsheet buffer

	-- File Explorer
	use("kyazdani42/nvim-tree.lua") -- tree viewer
	use("kyazdani42/nvim-web-devicons") -- icons for tree view

	-- Buffers
	use("moll/vim-bbye") -- close/delete buffers easier
	use("akinsho/bufferline.nvim") -- buffer lines
	use("nacro90/numb.nvim") -- peek lines of the buffer

	-- Terminal
	use("akinsho/toggleterm.nvim") -- toggle terminal

	-- Status Bar
	use("nvim-lualine/lualine.nvim") -- status bar/line

	-- Dashboard
	use("goolord/alpha-nvim") -- home page
	use("folke/which-key.nvim") -- show leader key bindings

	-- Sessions
	use("ahmedkhalf/project.nvim") -- project manager
	use("rmagatti/auto-session") -- save/restore sessions
	use("rmagatti/session-lens") -- use telescope to view sessions

	-- Code Runner
	use("is0n/jaq-nvim") -- run code of any language with `:`
	use({
		"0x100101/lab.nvim",
		run = "cd js && npm ci",
	}) -- prototype for js, ts, lua, and python

	-- Git
	use("lewis6991/gitsigns.nvim") -- git symbols

	-- Debug
	use("mfussenegger/nvim-dap") -- debugger
	use("rcarriga/nvim-dap-ui") -- debugger ui
	use("mfussenegger/nvim-dap-python") -- dap for python
	-- use("ravenxrz/DAPInstall.nvim") -- debugger installer - use Mason

	-- AI
	use("github/copilot.vim") -- code ai - use :Copilot setup

	-- Automatically set up configurations after cloning packer repo
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
