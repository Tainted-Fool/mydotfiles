return {
    -- Highlight same symbols under cursor
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" }, -- "LazyFile"
    keys = {
        { "]]", desc = "Next Reference (vim-illuminate)" },
        { "[[", desc = "Prev Reference (vim-illuminate)" },
    },
    opts = {
        delay = 100,
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        filetype_overrides = {},
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
            "alpha",
            "NvimTree",
            "packer",
            "neogitstatus",
            "Trouble",
            "lir",
            "Outline",
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
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
        min_count_to_highlight = 1,
    },
    config = function(_, opts)
        -- Map keybinds
        local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](true)
            end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference (vim-illuminate)", buffer = buffer })
        end
        map("]]", "next")
        map("[[", "prev")
        -- Overwrite bindings if they are already set
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]]", "next", buffer)
                map("[[", "prev", buffer)
            end,
        })
        require("illuminate").configure(opts)
    end
}
