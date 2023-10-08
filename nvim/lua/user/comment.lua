-- Use protected call so we know where error is coming from
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    vim.notify("comment.nvim plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local inlay_ok, inlay_hints = pcall(require, "lsp-inlayhints.core")
if not inlay_ok then
    vim.notify("lsp-inlayhints plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
if not utils_ok then
    vim.notify("nvim-ts-context-commentstring plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local internal_ok, internal = pcall(require, "ts_context_commentstring.internal")
if not internal_ok then
    vim.notify("nvim-ts-context-commentstring internals plugin was not found!")
    return
end

comment.setup({
    pre_hook = function(ctx)
        -- For inlay hints
        local line_start = (ctx.srow or ctx.range.srow) - 1
        local line_end = ctx.erow or ctx.range.erow
        inlay_hints.clear(0, line_start, line_end)

        -- For comment plugin
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

        -- Only calculate commentstring for javascript, typescript, and tsx filetypes
        if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
            -- Declare variable
            local U = require("Comment.utils")

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = utils.get_cursor_location()
            elseif ctx.motion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = utils.get_visual_start_location()
            end

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.type == U.ctype.linewise and "__default" or "__multiline"
            return internal.calculate_commentstring({
                key = type,
                location = location
            })
        end
    end
})

-- Set comments for filetypes
-- local comment_ft = require("Comment.ft")
-- comment_ft.set("lua", { "-- %s", "-- [[%s]]" })
