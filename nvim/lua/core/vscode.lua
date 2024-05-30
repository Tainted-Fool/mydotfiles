local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
    "tpope/vim-repeat", -- repeat last command
    "tpope/vim-unimpaired", -- useful mappings like ]space and ]b
    "tpope/vim-abolish", -- convert words to snake, camel, mix case 'crs', 'crc', 'crm'
    "tpope/vim-sleuth", -- Automatically adjusts 'tabstop', 'shiftwidth', and 'expandtab'
    "christoomey/vim-sort-motion", -- sort based on text objects or motions `gs`, `gs2j`, `gsi(`
    { "kylechui/nvim-surround", opts = {} }, -- add/change/delete surrounding pairs
    {
        "folke/flash.nvim",
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        opts = {
            jump = {
                autojump = true,
            },
            label = {
                rainbow = {
                    enabled = true,
                    shade = 2,
                },
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    autohide = true,
                    jump_labels = true,
                    multi_line = false,
                },
            }
        }
    },                               -- better navigation with f and t
    { "Wansmer/treesj", opts = {} }, -- split and join lines 
})
