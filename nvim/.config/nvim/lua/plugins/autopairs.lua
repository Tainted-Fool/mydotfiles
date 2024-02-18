return {
    -- Autopairs auto-completion and indentation
    'windwp/nvim-autopairs',
    -- lazy = true, -- load when nvim-tree-sitter loads
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, npairs = pcall(require, "nvim-autopairs")
        if not config_ok then
            vim.notify("nvim-autopairs plugin was not found!")
            return
        end

        -- Use protected call so we know where error is coming from
        local cmp_autopairs_ok , cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if not cmp_autopairs_ok then
            vim.notify("cmp_autopairs plugin was not found!")
            return
        end

        -- Use protected call so we know where error is coming from
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
            vim.notify("cmp plugin was not found!")
            return
        end

        npairs.setup({
            -- map_cr = true,
            check_ts = true, -- treesitting integration
            ts_config = {
                lua = {"string", "source"},
                javascript = {"string", "template_string"},
                java = false
            },
            disable_filetype = {"TelescopePrompt", "spectre_panel"}, -- disable autopairs for these filetypes
            fast_wrap = {
                map = "<M-e>", -- Alt+e then `$` to move to end
                chars = {"{", "[", "(", '"', "'"},
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0, -- Offset from pattern match
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr"
            }
        })

        -- Add utopairs to atuo-completion
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
}
