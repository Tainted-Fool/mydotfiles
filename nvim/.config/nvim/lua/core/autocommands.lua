-- Use 'q' to quit from plugins
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "man",
        "lspinfo",
        "spectre_panel",
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
    },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<cr>
            set nobuflisted
        ]])
    end
})

-- Remove stausline and tabline when in Alpha dashboard
vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    callback = function()
        vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]])
    end
})

-- Set 'wrap' and 'spell' in markdown and gitcommit
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown", "gitcommit"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Fix autocomment
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 200
        })
    end
})

-- Restore cursor position when opening recent file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end
})

-- Clear all notifications when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
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
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
        end
    end
})

-- Disable lsp_lines in floating windows like lazy plugin manager
vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "lazy",
    callback = function()
    local floating = vim.api.nvim_win_get_config(0).relative ~= ""
        vim.diagnostic.config({
            virtual_text = floating,
            virtual_lines = {
                only_current_line = not floating, -- show virtual text when your cursor is in line
            },
        })
    end
})

-- Enable/disable highlight group
vim.api.nvim_create_autocmd('CmdlineChanged', {
   -- group = 'AutoCommands',
   pattern = '*',
   callback = function()
       if vim.fn.getcmdtype() == '/'
           or vim.fn.getcmdtype() == '?'
           or string.sub(vim.fn.getcmdline(), 1, 2) == 'g/'
           or string.sub(vim.fn.getcmdline(), 1, 3) == 'g!/'
           or string.sub(vim.fn.getcmdline(), 1, 2) == 'v/'
       then
           vim.cmd('set hlsearch')
       else
           vim.cmd('set nohlsearch')
       end
   end
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
   -- group = 'AutoCommands',
   pattern = '*',
   callback = function()
       vim.cmd('set nohlsearch')
   end
})

-- Lazy and auto-sessions
-- local autocmd = vim.api.nvim_create_autocmd
-- local lazy_did_show_install_view = false
-- local function auto_session_restore()
--     -- important! without vim.schedule other necessary plugins might not load (eg treesitter) after restoring the session
--     vim.schedule(function()
--         require("auto-session").AutoRestoreSession()
--     end)
-- end
-- autocmd("User", {
--     pattern = "VeryLazy",
--     callback = function()
--         local lazy_view = require("lazy.view")
--
--         if lazy_view.visible() then
--             -- if lazy view is visible do nothing with auto-session
--             lazy_did_show_install_view = true
--         else
--             -- otherwise load (by require'ing) and restore session
--             auto_session_restore()
--         end
--     end,
-- })
-- autocmd("WinClosed", {
--     pattern = "*",
--     callback = function(ev)
--         local lazy_view = require("lazy.view")
--
--         -- if lazy view is currently visible and was shown at startup
--         if lazy_view.visible() and lazy_did_show_install_view then
--             -- if the window to be closed is actually the lazy view window
--             if ev.match == tostring(lazy_view.view.win) then
--                 lazy_did_show_install_view = false
--                 auto_session_restore()
--             end
--         end
--     end,
-- })
--
-- Execute cmd in each tab page or if range is given
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     callback = function()
--         vim.cmd("tabdo wincmd =")
--     end,
-- })
--
-- Quit cmd on enter
-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
--     callback = function()
--     vim.cmd("quit")
--     end,
-- })
--
-- Refresh code lens on file type
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = { "*.java", "*.py" },
--     callback = function()
--         vim.lsp.codelens.refresh()
--     end,
-- })
--
-- Pause highlight after 5000 lines
-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--     callback = function()
--         local line_count = vim.api.nvim_buf_line_count(0)
--         if line_count >= 5000 then
--             vim.cmd("IlluminatePauseBuf")
--         end
--     end,
-- })
--
-- Show Diagnostics on mouse hover
-- vim.api.nvim_create_autocmd("CursorHold", {
--     buffer = bufnr,
--     callback = function ()
--         local opts = {
--             foscusable = false,
--             close_events = {
--                 "BufLeave",
--                 "CursorMoved",
--                 "InsertEnter",
--                 "FocusLost"
--             },
--             border = "rounded",
--             source = "always",
--             prefix = " ",
--             scope = "cursor"
--         }
--         vim.diagnostic.open_float(nil, opts)
--     end
-- })
