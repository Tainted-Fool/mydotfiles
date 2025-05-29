return {
    -- Fuzzy finder
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.8",
    branch = "0.1.x",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim", -- useful lua functions
        "nvim-lua/popup.nvim", -- useful lua functions
        "nvim-telescope/telescope-file-browser.nvim", -- preview of file
        "nvim-telescope/telescope-ui-select.nvim", -- UI for telescope
        "nvim-telescope/telescope-dap.nvim", -- dap integration for telescope
        "debugloop/telescope-undo.nvim", -- undo tree for telescope
        "sudormrfbin/cheatsheet.nvim", -- cheatsheet buffer
        "ibhagwan/fzf-lua", -- Fzflua command
        {
            "nvim-telescope/telescope-fzf-native.nvim", -- fzf sorter for telescope
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end
        }
    },
    config = function()
        local icons = require("core.icons")
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local fb_actions = telescope.extensions.file_browser.actions
        telescope.setup({
            defaults = {
                prompt_prefix = icons.ui.Telescope .. " ",
                selection_caret = icons.ui.Forward .. " ",
                path_display = { "smart" },
                file_ignore_patterns = {
                    -- ".git",
                    ".next",
                    ".sl",
                    "_build",
                    "build",
                    "dist",
                    "node_modules",
                    "yarn.lock",
                },
                vimgrep_arguments = {
                    "rg", -- ripgrep
                    "--hidden", -- search hidden files
                    "--color=never", -- no color
                    "--no-heading", -- don't group matches by each file
                    "--with-filename", -- print the file path with the matched line
                    "--line-number", -- show line number
                    "--column", -- show column number
                    "--smart-case", -- smart case search
                    "--max-depth=2",
                    -- exclude directories from search
                    "--glob=!**/gef/*",
                    "--glob=!**/peda/*",
                    "--glob=!**/peda-arm/*",
                    "--glob=!**/pwndbg/*",
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-Down>"] = actions.cycle_history_next,
                        ["<C-Up>"] = actions.cycle_history_prev,
                    }
                },
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top", -- put prompt at the top
                        -- width = { padding = 0 }, -- use full screen
                        -- height = { padding = 0 }, -- use full screen
                        preview_width = 0.5,
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--max-depth=2",
                        "--glob=!**/gef/*",
                        "--glob=!**/peda/*",
                        "--glob=!**/peda-arm/*",
                        "--glob=!**/pwndbg/*",
                    }
                }
            },
            extensions = {
                file_browser = {
                    theme = "dropdown", -- dropdown, ivy, cursor
                    hidden = true,
                    auto_depth = true,
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = { }, -- own custom insert mode mappings
                        ["n"] = {
                            ["a"] = fb_actions.create
                        }
                    }
                },
                undo = {
                    side_by_side = true,
                    layout_strategy = "horizontal", -- horizontal, vertical
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })
        -- Load extensions
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
        telescope.load_extension("dap")
        telescope.load_extension("undo")
        telescope.load_extension("fzf")
        telescope.load_extension("projects")
        telescope.load_extension("noice")
    end,
    keys = {
        { "<leader>cm", "<cmd>Telescope notify<cr>", desc = "Display Messages (telescope)" },
        { "<leader>fa", "<cmd>Telescope commands<cr>", desc = "Lua Commands (telescope)" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (telescope)" },
        { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes (telescope)" },
        { "<leader>fC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes (fzf)" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files (telescope)" },
        { "<leader>fF", "<cmd>FzfLua files<cr>", desc = "Files (fzf)" },
        { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Git (fzf)" },
        { "<leader>fh", "<cmd>FzfLua command_history<cr>", desc = "Command History (fzf)" },
        { "<leader>fH", "<cmd>FzfLua search_history<cr>", desc = "History (fzf)" },
        { "<leader>fi", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups (telescope)" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps (telescope)" },
        { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages (telescope)" },
        { "<leader>fM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages (fzf)" },
        { "<leader>fn", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", desc = "Neovim Files (telescope)" },
        { "<leader>fN", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", desc = "Neovim Files (fzf)" },
        { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects (telescope)" },
        { "<leader>fP", "<cmd>Telescope pickers<cr>", desc = "History Pickers (telescope)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File (telescope)" },
        { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers (telescope)" },
        { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "Sessions (telescope)" },
        { "<leader>fS", "<cmd>FzfLua spell_suggest<cr>", desc = "Spelling (fzf)" },
        { "<leader>ft", "<cmd>Telescope help_tags<cr>", desc = "Help Tags (telescope)" },
        { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo History (telescope)" },
        { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word Under Cursor (telescope)" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches (telescope)" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits (telescope)" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Files (telescope)" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status (telescope)" },
        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (telescope)" },
        { "<leader>ue", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Explorer (telescope)" },
        { "<leader>xd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Diagnostics (telescope)" },
        { "<leader>xf", "<cmd>TodoTelescope<cr>", desc = "Todo (telescope)" },
        { "<leader>xF", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (telescope)" },
        { "<leader>xw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols (telescope)" },
        { "<leader>xW", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Diagnostics (telescope)" },
        { "<leader>xy", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols (telescope)" },
        { "<leader>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{winblend=10,previewer=true})<cr>", desc = "Fuzzy Find (telescope)" },
        { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet (telescope)" },
    }
}
