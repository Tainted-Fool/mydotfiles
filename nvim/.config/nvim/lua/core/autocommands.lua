local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
-- Use 'q' to quit from plugins
autocmd("FileType", {
    pattern = {
        "help",
        "man",
        "lspinfo",
        "lir",
        "fzf",
        "Jaq",
        "oil",
        "DressingSelect",
        "tsplayground",
        "netrw",
        "qf",
        "query",
        "vim",
        "notify",
        "checkhealth",
        "spectre_panel",
    },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]])
    end
})
-- Remove stausline and tabline when in Alpha dashboard
autocmd("User", {
    pattern = "AlphaReady",
    callback = function()
        vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]])
    end
})
-- Set 'wrap' and 'spell' in markdown and gitcommit
autocmd("FileType", {
    pattern = {"markdown", "gitcommit"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})
-- Fix autocomment
autocmd("BufWinEnter", {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end
})
-- Highlight yanked text
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 200
        })
    end
})
-- Restore cursor position when opening recent file
autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end
})
-- Clear all notifications when entering insert mode
autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("NotifyClearGrp", {}),
    pattern = "*",
    callback = function()
        require("notify").dismiss({
            silent = true
        })
    end
})
-- Automatically close tab when nvim-tree is the last window in tab
-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
autocmd("BufEnter", {
    nested = true,
    callback = function()
        if vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
        end
    end
})
-- Disable lsp_lines in floating windows like lazy plugin manager
autocmd("WinEnter", {
    pattern = "lazy",
    callback = function()
    local floating = vim.api.nvim_win_get_config(0).relative ~= ""
        vim.diagnostic.config({
            virtual_text = floating,
            virtual_lines = {
                only_current_line = not floating, -- show virtual text when your cursor is in line
            }
        })
    end
})
-- Disable diagnostics in insert mode
autocmd('ModeChanged', {
    pattern = { 'n:i', 'v:s' },
    desc = 'Disable diagnostics in insert and select mode',
    callback = function()
        vim.diagnostic.enable(false)
    end
})
-- Enable diagnostics in normal mode
autocmd('ModeChanged', {
    pattern = 'i:n',
    desc = 'Enable diagnostics when leaving insert mode',
    callback = function()
        vim.diagnostic.enable(true)
    end
})
-- Create a 'Format' command for formatting files
cmd("Format", function()
    vim.cmd("lua vim.lsp.buf.format{async=true}")
end, { desc = "Format" })
-- Change working directory
cmd("Cwd", function()
  vim.cmd(":cd %:p:h")
  vim.cmd(":pwd")
end, { desc = "Change working directory" })
