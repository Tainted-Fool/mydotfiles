-- global settings

local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- configure plugins
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "tpope/vim-repeat"
    use "tpope/vim-surround"
	use "tpope/vim-unimpaired"
	use "tpope/vim-abolish"
	use "justinmk/vim-sneak"
	use "easymotion/vim-easymotion"
	use {
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end
		}
	use {
			"karb94/neoscroll.nvim",
			event = "WinScrolled",
			config = function()
				require("neoscroll").setup({
					mappings = { 
						"<C-u>",
						"<C-d>",
						"<C-b>",
						"<C-f>",
						"<C-y>",
						"<C-e>",
						"zt",
						"zz",
						"zb"
					},
					hide_cursor = true,
					stop_eof = true,
					use_local_scrolloff = false,
					respect_Scrolloff = false,
					cursor_scrolls_alone = true,
					easing_function = nil,
					pre_hook = nil,
					post_hook = nil
				})
			end
		}
	
	-- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- Options
vim.opt.clipboard:append("unnamedplus") -- setup this way
vim.opt.shortmess:append("c")
vim.cmd("set whichwrap+=<,>[,],h,l") -- or this way
vim.cmd("set iskeyword+=-")

-- Plugin settings - EasyMotion
vim.cmd("map - <Plug>(easymotion-prefix)")
vim.cmd("let g:EasyMotion_disable_two_key_combo = 1")

-- vscode settings
if (vim.g.vscode) then
	require "user.vskeymaps"
else
	-- ordinary neovim
end