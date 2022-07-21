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
	use {
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end
		}
	
	-- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end
)

vim.opt.clipboard:append("unnamedplus")

-- vscode settings
if (vim.g.vscode) then
	-- VSCode extensions
else
	-- ordinary neovim
end