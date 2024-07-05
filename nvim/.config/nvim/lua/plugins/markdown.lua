return {
    {
        -- Live markdown previewer
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        -- Add highlights to buffers
        "lukas-reineke/headlines.nvim",
        enabled = false, -- disable plugin
        opts = function()
            local opts = {}
            -- Create a table for each filetype
            for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
                -- Set options for each filetype
                opts[ft] = {
                    headline_highlights = {},
                    fat_headlines = true,
                    fat_headline_upper_string = "▄",
                    fat_headline_lower_string = "▀",
                    bullets = {}, -- reset bullets until substitution is fixed
                }
                -- Set the headlines groups for each filetype
                for i = 1, 6 do
                    local hl = "Headline" .. i
                    vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
                    table.insert(opts[ft].headline_highlights, hl)
                end
            end
            return opts
        end,
        ft = { "markdown", "norg", "rmd", "org" },
        config = function(_, opts)
            -- Define custom highlight groups using Vimscript
            vim.cmd([[highlight Headline1 guibg=#295715 guifg=white]])
            vim.cmd([[highlight Headline2 guibg=#8d8200 guifg=white]])
            vim.cmd([[highlight Headline3 guibg=#a56106 guifg=white]])
            vim.cmd([[highlight Headline4 guibg=#7e0000 guifg=white]])
            vim.cmd([[highlight Headline5 guibg=#1e0b7b guifg=white]])
            vim.cmd([[highlight Headline6 guibg=#560b7b guifg=white]])
            -- Defines the codeblock background color to something darker
            -- vim.cmd([[highlight CodeBlock guibg=#09090d]])
            vim.cmd([[highlight CodeBlock guibg=#111014]])
            -- PERF: schedule to prevent headlines slowing down opening a file
            vim.schedule(function()
                require("headlines").setup(opts)
                require("headlines").refresh()
            end)
        end
    },
    {
        -- Auto complete list continuation and formatting
        "gaoDean/autolist.nvim",
        enabled = false, -- disable plugin
        ft = {
            "markdown",
            "text",
            "tex",
            "plaintex",
            "norg",
        },
        config = function()
            local keymap = vim.keymap.set
            require("autolist").setup()
            keymap("n", "o", "o<cmd>AutolistNewBullet<cr>", { desc = "AutolistNewBullet", noremap = true, silent = true })
            keymap("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { desc = "AutolistNewBulletBefore", noremap = true, silent = true })
            keymap("n", "<cr>", "<cmd>AutolistToggleCheckbox<cr><cr>", { desc = "AutolistToggleCheckbox", noremap = true, silent = true })
            keymap("n", ">>", ">><cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("n", "<<", "<<<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("n", "dd", "dd<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("v", "d", "d<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
        end
    },
    {
        -- Markdown renderer
        "meanderingprogrammer/markdown.nvim",
        -- cmd = { "RenderMarkdownToggle" },
        ft = "markdown",
        name = "render-markdown",
        config = function()
            require("render-markdown").setup({
                highlights = {
                    heading = {
                        backgrounds = {
                            "DiffAdd",
                            "DiffChange",
                            "DiffText",
                            "WildMenu",
                            "DiffDelete",
                        }
                    }
                }
            })
        end
    },
    {
        -- Markdown syntax highlighting and configurable tools
        "tadmccorkle/markdown.nvim",
        ft = "markdown",
        opts = {
            mappings = {
                inline_surround_toggle = false, -- toggle inline style default:`gs`
                inline_surround_toggle_line = false, -- toggle line-wise inline style default:`gss`
                inline_surround_delete = false, -- delete emphasis surrounding curosr default:`ds`
                inline_surround_change = false, -- chgange emphasis surrounding curosr default:`cs`
                link_add = false, -- add link default:`gl`
                link_follow = "gx", -- follow link default:`gx`
                go_curr_heading = false, -- go to current heading default:`]c`
                go_parent_heading = false, -- go to parent heading default:`]p`
                go_next_heading = false, -- go to next heading default:`]]`
                go_prev_heading = false, -- go to previous heading default:`[[`
                on_attach = function(bufnr)
                    local map = vim.keymap.set
                    local opts = { buffer = bufnr }
                    local function toggle(key)
                        return "<Esc>gv<cmd>lua require'markdown.inline'" .. ".toggle_emphasis_visual'" .. key .. "'1<cr>"
                    end
                    -- Keymaps
                    map({ "n", "i" }, "<M-l><M-o>", "<cmd>MDListItemBelow<cr>", opts)
                    map({ "n", "i" }, "<M-L><M-O>", "<cmd>MDListItemAbove<cr>", opts)
                    map("n", "<M-c>", "<cmd>MDtaskToggle<cr>", opts)
                    map("x", "<M-c>", ":MDTaskToggle<cr>", opts)
                    map("x", "<C-b>", toggle("b"), opts) -- strong/bold toggle
                    map("x", "<C-i>", toggle("i"), opts) -- emphasis/italics toggle
                end
            }
        }
    }
}
