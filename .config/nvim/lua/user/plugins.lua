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
    -- print("Something went wrong with Packer")
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
    use "lewis6991/impatient.nvim"        -- speed up loading lua modules

    -- Packer can manage itself
    use "wbthomason/packer.nvim"          -- plugin manager

    -- Colorschemes
    use "rafi/awesome-vim-colorschemes"
    use "folke/tokyonight.nvim"

    -- Autocompletion
    use "hrsh7th/nvim-cmp"                -- the auto completion plugin
    use "hrsh7th/cmp-buffer"              -- buffer completion
    use "hrsh7th/cmp-cmdline"             -- cmdline completion
    use "hrsh7th/cmp-path"                -- path completion
    use "hrsh7th/cmp-nvim-lsp"            -- lsp completion
    use "hrsh7th/cmp-nvim-lua"            -- lua completion
    use "saadparwaiz1/cmp_luasnip"        -- snippet completion

    -- Snippets
    use "L3MON4D3/LuaSnip"                -- snippet engine
    use "rafamadriz/friendly-snippets"    -- snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"           -- enable lsp
    use "williamboman/nvim-lsp-installer" -- easy install lsp servers
    use "jose-elias-alvarez/null-ls.nvim" -- formatting and linters
    use "RRethy/vim-illuminate"           -- highlight same words in different lines
    use "folke/lua-dev.nvim"              -- nvim lua API
    use "arkav/lualine-lsp-progress"      -- indicator that shows when lsp is ready

    -- Fuzzy Search
    use "nvim-telescope/telescope.nvim"   -- find files

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter" -- syntax highlighting
    use "p00f/nvim-ts-rainbow"            -- rainbow pairs for treesitter

    -- Utilities
    use "nvim-lua/plenary.nvim"           -- useful lua functions
    use "nvim-lua/popup.nvim"             -- useful lua functions
    use "antoinemadec/FixCursorHold.nvim" -- fix cursor hold
    use "windwp/nvim-autopairs"           -- auto pairs
    use "numToStr/Comment.nvim"           -- comment/uncomment
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "kyazdani42/nvim-tree.lua"        -- tree view
    use "kyazdani42/nvim-web-devicons"    -- icons for tree view
    use "moll/vim-bbye"                   -- close/delete buffers easier
    use "akinsho/bufferline.nvim"         -- buffer lines
    use "akinsho/toggleterm.nvim"         -- toggle terminal
    use "nvim-lualine/lualine.nvim"       -- status bar/line
    use "ahmedkhalf/project.nvim"         -- project manager
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"              -- dashboard
    use "folke/which-key.nvim"            -- show leader key bindings
    use "folke/trouble.nvim"              -- better quickfix for diagnostics
    use "karb94/neoscroll.nvim"           -- better scrolling
    use "rcarriga/nvim-notify"            -- better notifications
    use "ray-x/lsp_signature.nvim"        -- better signature help
    use "tpope/vim-repeat"                -- repeat last command
    use "tpope/vim-surround"              -- change or add surroundings
    use "tpope/vim-unimpaired"            -- useful mappings like ]space
    use "tpope/vim-abolish"               -- convert words to camel, mix, with 'crc'
    use "justinmk/vim-sneak"              -- faster motion with 's'
    -- use "easymotion/vim-easymotion"       -- faster motion with '<leader><leader>'

    -- Git
    use "lewis6991/gitsigns.nvim"         -- git symbols

    -- Debug
    use "mfussenegger/nvim-dap"           -- debugger
    use "rcarriga/nvim-dap-ui"            -- debugger ui
    use "ravenxrz/DAPInstall.nvim"        -- debugger installer
    -- use "Pocco81/dap-buddy.nvim"          -- debugger installer

    -- Automatically set up configurations after cloning packer repo
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
