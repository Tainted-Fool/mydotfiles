-- Automatically install Packer
local fn = vim.fn
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

-- Autocommand that runs 'PackerSync' whenever you save the vsplugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost vsplugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use protected call so we know where error is coming from
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    -- print("Something went wrong with Packer")
    vim.notify("packer plugin was not found!")
    return
end

-- configure plugins
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "tpope/vim-repeat"
  use "tpope/vim-surround"
	use "tpope/vim-abolish"
	use "tpope/vim-commentary"
	use "justinmk/vim-sneak"
	use "easymotion/vim-easymotion"
  use "numToStr/Comment.nvim"

	-- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
