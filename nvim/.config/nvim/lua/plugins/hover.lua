return {
    -- Better hover capabilities with 'K' and 'gk'
    "lewis6991/hover.nvim",
    event = "VeryLazy",
    keys = {
        { "K", "<cmd>lua require('hover').hover()<cr>", desc = "Show Hover (hover)" },
        { "gk", "<cmd>lua require('hover').hover_select()<cr>", desc = "Show Hover Select (hover)" },
    },
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
    end
}
