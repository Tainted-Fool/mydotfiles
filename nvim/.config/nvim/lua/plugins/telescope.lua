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
        "nvim-tree/nvim-web-devicons", -- icons for telescope
        "debugloop/telescope-undo.nvim", -- undo tree for telescope
        "sudormrfbin/cheatsheet.nvim", -- cheatsheet buffer
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
        telescope.load_extension("dap")
        telescope.load_extension("ui-select")
        telescope.load_extension("fzf")
        telescope.load_extension("noice")
        telescope.load_extension("projects")
        telescope.load_extension("session-lens")
        telescope.load_extension("undo")
        -- telescope.load_extension("mapper")
    end
}
