return {
     -- highlight same symbols under cursor
    "RRethy/vim-illuminate",
    -- enabled = false, -- disable plugin

    config = function()

        -- Use protected call so we know where error is coming from
        local config_ok, illuminate = pcall(require, "illuminate")
        if not config_ok then
            vim.notify("vim-illuminate plugin was not found!")
            return
        end

        illuminate.configure({
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            delay = 100,
            filetype_overrides = {},
            filetypes_denylist = {
                'dirbuf',
                'dirvish',
                'fugitive',
                "alpha",
                "NvimTree",
                "packer",
                "neogitstatus",
                "Trouble",
                "lir",
                "Outline",
                "spectre_panel",
                "toggleterm",
                "DressingSelect",
                "TelescopePrompt",
            },
            filetypes_allowlist = {},
            modes_denylist = {},
            modes_allowlist = {},
            providers_regex_syntax_denylist = {},
            providers_regex_syntax_allowlist = {},
            under_cursor = true,
            large_file_cutoff = nil,
            large_file_overrides = nil,
            min_count_to_highlight = 1,
            should_enable = function(bufnr) return true end,
            case_insensitive_regex = false,
        })
    end
}
