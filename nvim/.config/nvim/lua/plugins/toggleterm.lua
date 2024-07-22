return {
    -- Toggle terminal
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = "ToggleTerm",
    keys = {
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float (Toggleterm)"},
        { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal (Toggleterm)" },
        { "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit (Toggleterm)" },
        { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node (Toggleterm)" },
        { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python (Toggleterm)" },
        { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "HTop (Toggleterm)" },
        { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "Disk Usage (Toggleterm)" },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical (Toggleterm)" },
    },
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<C-\]],
            hide_numbers = true,
            shade_filetypes = {},
            share_Terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                }
            }
        })
        function _G.set_terminal_keymaps()
            local opts = {
                noremap = true
            }
            local bufkeymap = vim.api.nvim_buf_set_keymap
            bufkeymap(0, "t", "<ESC>", [[<C-\><C-n>]], opts)
            bufkeymap(0, "t", "fj", [[<C-\><C-n>]], opts)
            bufkeymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
            bufkeymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
            bufkeymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
            bufkeymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
        end
        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
            on_close = function(term)
                vim.cmd("startinsert!")
            end
        })
        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end
        local node = Terminal:new({
            cmd = "node",
            hidden = true,
        })
        function _NODE_TOGGLE()
            node:toggle()
        end
        local ncdu = Terminal:new({
            cmd = "ncdu",
            hidden = true,
        })
        function _NCDU_TOGGLE()
            ncdu:toggle()
        end
        local htop = Terminal:new({
            cmd = "htop",
            hidden = true,
        })
        function _HTOP_TOGGLE()
            htop:toggle()
        end
        local python = Terminal:new({
            cmd = "python",
            hidden = true,
        })
        function _PYTHON_TOGGLE()
            python:toggle()
        end
    end
}
