return {
    -- Better fold
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
        "masukomi/vim-markdown-folding", -- fold markdown documents by section
        "kevinhwang91/promise-async",
        {
            -- Better status column
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    bt_ignore = { "dashboard", "NvimTree", "Lazy" },
                    segments = {
                        { text = { "%s" }, click = "v:lua.ScSa" }, -- gitsigns (moves diagnostic too)
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- line number
                        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- fold icons
                    }
                })
            end
        }
    },
    config = function()
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] -- fold icons
        vim.o.foldcolumn = "1" -- show foldcolumn
        vim.o.foldenable = true -- enable fold for nvim-ufo
        vim.o.foldlevel = 99 -- set highest folder level for nvim-ufo
        vim.o.foldlevelstart = 99 -- start with all the code unfolded
        vim.g.markdown_folding = true -- enable markdown folding
        vim.g.markdown_fold_style = "nested"
        -- vim.o.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
        -- vim.o.statuscolumn = "%=%l%s%C"
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local totalLines = vim.api.nvim_buf_line_count(0)
            local foldedLines = endLnum - lnum
            local suffix = ("󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
            suffix = (" "):rep(rAlignAppndx) .. suffix
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end
        vim.keymap.set("n", "zR", "<cmd>lua require('ufo').openAllFolds()<CR>", { desc = "Open All Folds (nvim-ufo)" })
        vim.keymap.set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", { desc = "Close All Folds (nvim-ufo)" })
        vim.keymap.set("n", "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", { desc = "Open Less Folds (nvim-ufo)" })
        require("ufo").setup({
            -- uncomment to use treesitter as fold provider or defaults to nvim lsp :149
            -- provider_selection = function()
            --     return { "treesitter", "indent" }
            -- end,
            open_fold_hl_timeout = 400,
            close_fold_kinds_for_ft = {},
            fold_virt_text_handler = handler,
            enable_get_fold_virt_text = true,
            preview = {
                win_config = {
                    border = "rounded",
                    winblend = 0,
                }
            }
        })
    end
}
