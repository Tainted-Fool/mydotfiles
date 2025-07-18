return {
    -- Show leader key bindings
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>k",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Keymaps (which-key)"
        },
        {
            "<c-w><space>",
            function()
                require("which-key").show({ keys = "<c-w>", loop = true })
            end,
            desc = "Window Hydra Mode (which-key)",
        }
    },
    dependencies = {
        "echasnovski/mini.icons", -- icon provider
        version = false,
    },
    opts = {
        ---@type string false|classic|modern|helix
        preset = "helix",
        notify = true,
        show_help = true, -- show help message on the command line when the popup is visible
        show_keys = true, -- show the currently pressed key and its label as a message in the command line
        -- sort = { "local", "order", "group", "alphanum", "mod" }, -- default
        sort = { "order", "alphanum", "mod", "group", "local" },
        plugins = {
            marks = true, -- show a list of your marks on ' and `
            registers = true, -- show your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z=
                suggestions = 20
            },
            presets = {
                operators = true, -- adds help for operators like d, y, c, s, etc.
                motions = true, -- adds help for motions
                text_objects = true, -- adds help for text objects triggered after entering an operator
                windows = true, -- default bindings on <C-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            }
        },
        win = {
            no_overlap = false,
            title = true,
            ---@type string left|center|right
            title_pos = "center",
            wo = { winblend = 20 },
        },
        spec = {
            -- Single keymaps
            { "<leader>q", "<cmd>q!<cr>", desc = "Quit" },
            { "<leader>-", "<C-W>s", desc = "Split Window Below" },
            { "<leader>\\", "<C-W>v", desc = "Split Window Right" },
            -- Buffer keymaps
            { "<leader>ba", "<cmd>%bd<cr>:e#<cr>:bd#<cr>", desc = "Close All" },
            { "<leader>bc", "<cmd>bd!<cr>", desc = "Close" },
            { "<leader>bf", "<cmd>Format<cr>:w<cr>", desc = "Format and Save" },
            { "<leader>bo", "<cmd>e #<cr>", desc = "Other" },
            { "<leader>bq", "<cmd>q!<cr>", desc = "Quit" },
            { "<leader>bQ", "<cmd>wq!<cr>", desc = "Save and Quit" },
            { "<leader>bw", "<cmd>w<cr>", desc = "Save/Write" },
            { "<leader>bx", "<cmd>w<cr>:bd!<cr>", desc = "Save and Close" },
            -- Code keymaps
            { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Actions" },
            { "<leader>cA", "<cmd>!chmod +x %<cr>", desc = "Add Execute Bit" },
            { "<leader>cR", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename Variable" },
            { "<leader>cx", "<cmd>.lua<cr>", desc = "Execute Lua Line" },
            { "<leader>cX", "<cmd>source %<cr>", desc = "Source File" },
            -- UI keymaps
            { "<leader>ud", "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>", desc = "Toggle Diagnostics" },
            { "<leader>ui", "<cmd>Inspect<cr>", desc = "Inspect" },
            { "<leader>uI", "<cmd>InspectTree<cr>", desc = "Inspect Symbols" },
            { "<leader>ul", "<cmd>Lazy<cr>", desc = "Plugin Manager (Lazy)" },
            { "<leader>un", "<cmd>nohlsearch<cr>", desc = "No Highlight" },
            { "<leader>uR", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", desc = "Redraw/Clear hlsearch/Diff Update" },
            -- Window keymap
            { "<leader>wc", "<C-w>c", desc = "Close Window" },
            { "<leader>we", "<C-w>=", desc = "Split Window Equal Size" },
            { "<leader>wo", "<C-w>o", desc = "Close All Other Windows" },
            { "<leader>ws", "<C-w>s", desc = "Split Window Below" },
            { "<leader>wv", "<C-w>v", desc = "Split Window Right" },
            { "<leader>ww", "<C-w>w", desc = "Switch Windows" },
            -- Groups
            {
                "<leader>b",
                group = "buffer",
                expand = function()
                    return require("which-key.extras").expand.buf()
                end
            },
            { "<leader>c", group = "code" },
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>G", group = "gag" },
            { "<leader>s", group = "search" },
            {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function()
                    return require("which-key.extras").expand.win()
                end
            },
            {
                "<leader>u",
                group = "ui",
                icon = {
                    icon = require("core.icons").misc.UI,
                    ---@type string azure|blue|cyan|green|grey|orange|purple|red|yellow
                    color = "cyan",
                }
            },
            {
                "<leader>x",
                group = "diagnostics/quickfix",
                icon = {
                    icon = require("core.icons").misc.Quickfix,
                    color = "green",
                }
            },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "z", group = "fold" },
        },
        icons = {
            rules = {
                { pattern = "alpha", icon = require("core.icons").misc.Dashboard, color = "purple" },
                { pattern = "explorer", icon = require("core.icons").misc.Explorer, color = "azure" },
                { pattern = "fzf", icon = require("core.icons").misc.FZF, color = "orange" },
                { pattern = "gag", icon = require("core.icons").misc.Fun, color = "red" },
                { pattern = "goose", icon = require("core.icons").misc.Egg, color = "grey" },
                { plugin = "harpoon", pattern = "harpoon", icon = require("core.icons").misc.Harpoon, color = "cyan" },
                { plugin = "multicursor", pattern = "multicursor", icon = require("core.icons").misc.Cursor, color = "red" },
                { pattern = "snow", icon = require("core.icons").misc.Snow, color = "azure" },
                { plugin = "venv-selector.nvim", pattern = "venv", icon = require("core.icons").misc.VENV, color = "green" },
            }
        }
    }
}
