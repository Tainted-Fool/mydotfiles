return {
    -- Better hover capabilities with 'K' and 'gK'
    "lewis6991/hover.nvim",
    config = function()
        local util = vim.lsp.util
        local ___ =
        "\n─────────────────────────────────────────────────────────────────────────────\n"
        local LSPWithDiagSource = {
            name = "LSP",
            priority = 1000,
            enabled = function()
                return true
            end,
            execute = function(_, done)
                local params = util.make_position_params()
                vim.lsp.buf_request_all(0, "textDocument/hover", params, function(responses)
                    local value = ""
                    for _, response in pairs(responses) do
                        local result = response.result
                        if result and result.contents and result.contents.value then
                            if value ~= "" then
                                value = value .. ___
                            end
                            value = value .. result.contents.value
                        end
                    end
                    local _, row = unpack(vim.fn.getpos("."))
                    local lineDiag = vim.diagnostic.get(0, { lnum = row - 1 })
                    for _, d in pairs(lineDiag) do
                        if d.message then
                            if value ~= "" then
                                value = value .. ___
                            end
                            value = value .. string.format("*%s* %s", d.source, d.message)
                        end
                    end
                    value = value:gsub("\r", "")
                    if value ~= "" then
                        done({ lines = vim.split(value, "\n"), filetype = "markdown" })
                    else
                        done()
                    end
                end)
            end
        }
        local hover = require("hover")
        hover.setup({
            init = function()
                hover.register(LSPWithDiagSource)
                require("hover.providers.dictionary")
            end,
            preview_opts = {
                border = "rounded", -- rounded, single, double, shadow
            },
            preview_window = false,
            title = true,
        })
        vim.keymap.set("n", "K", hover.hover, { desc = "Show hover", noremap = true, silent = true })
        vim.keymap.set("n", "gK", hover.hover_select, { desc = "Show hover select", noremap = true, silent = true })
    end
}
