return {
    -- Tree viewer
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer (nvim-tree)" },
    },
    config = function()
        local icons = require("core.icons")
        local function myattach(bufnr)
            local api = require("nvim-tree.api")
            local keymap = vim.keymap.set
            local function opts(desc)
                return {
                    desc = desc .. " (nvim-tree)",
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                }
            end
            -- Loads default mappings
            api.config.mappings.default_on_attach(bufnr)
            -- Custom mappings
            keymap("n", "l", api.node.open.no_window_picker, opts("Open"))
            keymap("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
            keymap("n", "\\", api.node.open.vertical, opts("Open: Vertical Split"))
            keymap("n", "-", api.node.open.horizontal, opts("Open: Horizontal Split"))
            keymap("n", "?", api.tree.toggle_help, opts("Help"))
        end
        require("nvim-tree").setup({
            on_attach = myattach, -- override default mappings
            sync_root_with_cwd = false, -- default: false
            respect_buf_cwd = false, -- default: false
            update_focused_file = {
                -- Update the focused file on `BufEnter`
                enable = true, -- default: false
                update_root = {
                    -- Update the root directory of the tree if the file is not under current root directory
                    enable = true, -- default: false
                }
            },
            view = {
                width = 35,
            },
            renderer = {
                root_folder_label = ":t",
                indent_markers = {
                    enable = true, -- default: false
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = icons.ui.ChevronShortRight,
                            arrow_open = icons.ui.ChevronShortDown,
                        },
                        git = {
                            unstaged = icons.git.FileUnstaged,
                            staged = icons.git.FileStaged,
                            unmerged = icons.git.FileUnmerged,
                            renamed = icons.git.FileRenamed,
                            untracked = icons.git.FileUntracked,
                            deleted = icons.git.FileDeleted,
                            ignored = icons.git.FileIgnored,
                        }
                    }
                }
            },
            diagnostics = {
                enable = true, -- default: false
                show_on_dirs = true, -- default: false
                icons = {
                    hint = icons.diagnostics.Hint,
                    info = icons.diagnostics.Information,
                    warning = icons.diagnostics.Warning,
                    error = icons.diagnostics.Error,
                }
            },
            actions = {
                open_file = {
                    window_picker = {
                        -- If the feature is not enabled, files will open in window from which you last opened the tree
                        enable = false, -- default: true
                    },
                    -- Closes the explorer when opening a file
                    quit_on_open = true, -- default: false
                }
            }
        })
    end
}
