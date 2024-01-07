-- Declare variable
local fn = vim.fn

-- Automatically install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path})
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

-- Have Packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "rounded"
            })
        end
    }
})

-- configure plugins
require("packer").startup(function(use)
    use "wbthomason/packer.nvim" -- plugin manager
    use "tpope/vim-repeat" -- repeat plugin commands
    --[[ use "tpope/vim-surround" ]] -- add/change/delete surrounding pairs
    use "kylechui/nvim-surround" -- add/change/delete surrounding pairs
    use "tpope/vim-abolish" -- conver words to camel, mix with `crc`
    --[[ use "tpope/vim-commentary" ]] -- comment/uncomment
    use "justinmk/vim-sneak" -- faster motion with `s`
    --[[ use "easymotion/vim-easymotion" ]] -- faster motion with dash `-` `<motion>`
    use "phaazon/hop.nvim" -- better navigation with `f` and `t`
    use "numToStr/Comment.nvim" -- comment/uncomment
    use "christoomey/vim-sort-motion" -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
