return {
    {
        -- add highlights to buffers
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
        end,
    },
    {
        -- auto complete list continuation and formatting
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
            -- keymap("n", "<ESC>", ":noh<CR><ESC>", {desc = "Escape and clear hlsearch", noremap = true, silent = true})
            -- keymap("i", "<tab>", "<cmd>AutolistTab<cr>", { desc = "AutolistTab", noremap = true, silent = true }),
            -- keymap("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>", { desc = "AutolistShiftTab", noremap = true, silent = true }),
            -- keymap("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>", {desc = "AutolistRecalculate", noremap = true, silent = true}) -- an example of using <c-t> to indent
            -- keymap("i", "<cr>", "<CR><cmd>AutolistNewBullet<cr>", {desc = "AutolistNewBullet", noremap = true, silent = true}), -- conflicts with nvim-autopairs (below didnt work)
            -- keymap("i", "<CR>", function()
            --   -- run autolist-new-bullet after the <cr> of nvim-autopairs-cr
            --   -- timeout of 0ms delays enough for my computer but you might need to adjust
            --   local timeoutms = 10
            --   vim.loop.new_timer():start(timeoutms, 0, vim.schedule_wrap(function()
            --     require("autolist").new_bullet()
            --   end))
            --
            --   require("nvim-autopairs").autopairs_cr()
            -- end, {desc = "AutolistNewBullet", noremap = true, expr = true}),
            keymap("n", "o", "o<cmd>AutolistNewBullet<cr>", { desc = "AutolistNewBullet", noremap = true, silent = true })
            keymap("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { desc = "AutolistNewBulletBefore", noremap = true, silent = true })
            keymap("n", "<cr>", "<cmd>AutolistToggleCheckbox<cr><cr>", { desc = "AutolistToggleCheckbox", noremap = true, silent = true })
            -- keymap("n", "<c-r>", "<cmd>AutolistRecalculate<cr>", {desc = "AtuolistRecalculate", noremap = true, silent = true}),

            -- cycle list types with dot-repeat
            -- keymap("n", "<leader>cn", "<cmd>AtuolistCycleNextDr<cr>", { desc = "AutolistCycleNextDr", noremap = true, silent = true, expr = true }),
            -- keymap("n", "<leader>cp", "<cmd>AtuolistCyclePrevDr<cr>", { desc = "AutolistCyclePrevDr", noremap = true, silent = true, expr = true }),

            -- if you don't want dot-repeat
            -- keymap("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>", {desc = "AutolistCycleNext", noremap = true, silent = true})
            -- keymap("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>", {desc = "AutolistCycleNext", noremap = true, silent = true})

            -- functions to recalculate list on edit
            keymap("n", ">>", ">><cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("n", "<<", "<<<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("n", "dd", "dd<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
            keymap("v", "d", "d<cmd>AutolistRecalculate<cr>", { desc = "AutolistRecalculate", noremap = true, silent = true })
        end,
    },
    {
        "meanderingprogrammer/markdown.nvim", -- markdown renderer
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
        "tadmccorkle/markdown.nvim", -- markdown syntax highlighting
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

                    -- buffer only keymaps
                    map({ "n", "i" }, "<M-l><M-o>", "<cmd>MDListItemBelow<cr>", opts)
                    map({ "n", "i" }, "<M-L><M-O>", "<cmd>MDListItemAbove<cr>", opts)
                    map("n", "<M-c>", "<cmd>MDtaskToggle<cr>", opts)
                    map("x", "<M-c>", ":MDTaskToggle<cr>", opts)
                    map("x", "<C-b>", toggle("b"), opts) -- strong/bold toggle
                    map("x", "<C-i>", toggle("i"), opts) -- emphasis/italics toggle
                end
            }
        }
    },
}
