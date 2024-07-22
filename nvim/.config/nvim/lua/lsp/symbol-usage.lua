return {
    -- Display LSP reference, definition, and implementation
    "wansmer/symbol-usage.nvim",
    event = "BufReadPre",
    config = function()
        local function text_format(symbol)
            local fragments = {}
            local stacked_functions = symbol.stacked_count > 0
            and (' | +%s'):format(symbol.stacked_count)
            or ''
            if symbol.references then
                local usage = symbol.references <= 1 and 'usage' or 'usages'
                local num = symbol.references == 0 and 'no' or symbol.references
                table.insert(fragments, ('%s %s'):format(num, usage))
            end
            if symbol.definition then
                table.insert(fragments, symbol.definition .. ' defs')
            end
            if symbol.implementation then
                table.insert(fragments, symbol.implementation .. ' impls')
            end
            return table.concat(fragments, ', ') .. stacked_functions
        end
        require('symbol-usage').setup({
            text_format = text_format,
            ---@type string above|end_of_line|textwidth|signcolumn
            vt_position = "end_of_line",
            references = {
                enabled = true,
                include_declaration = true, -- default:false
            },
            definition = {
                enabled = true, -- default:false
            },
            implementation = {
                enabled = true, -- default:false
            },
            disable = {
                filetype = {
                    "help",
                    "vim",
                    "Lazy",
                }
            }
        })
    end
}
