-- Use 'q' tp quit from plugins
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"qf", "help", "man", "lspinfo", "spectre_panel", "lir"},
    callback = function()
        vim.cmd [[
            nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]]
    end
})

-- Remove stausline and tabline when in Alpha dashboard
vim.api.nvim_create_autocmd({"User"}, {
    pattern = {"AlphaReady"},
    callback = function()
        vim.cmd [[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]]
    end
})

-- Set 'wrap' and 'spell' in markdown and gitcommit
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"markdown", "gitcommit"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Fix autocomment
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end
})

-- Highlight yanked text
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank {higroup = "Visual", timeout = 200}
    end
})

-- Restore cursor position when opening recent file
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
