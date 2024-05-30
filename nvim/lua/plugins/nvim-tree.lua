return {
    -- tree viewer
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle" },
    -- opts = {}, -- require("nvim-tree").setup(opts)

    config = function()

        local function on_attach(bufnr)
            local api = require('nvim-tree.api')
            local keymap = vim.keymap.set

            local function opts(desc)
                return {
                    desc = 'nvim-tree: ' .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            -- Loads default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- BEGIN_CUSTOM_ON_ATTACH
            keymap('n', 'l', api.node.open.no_window_picker, opts('Open'))
            keymap('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
            keymap('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
            keymap('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
            keymap('n', '?', api.tree.toggle_help, opts('Help'))
            -- END_CUSTOM_ON_ATTACH
        end

        require("nvim-tree").setup({
            -- open_on_setup = true,
            -- auto_close = true,
            on_attach = on_attach,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true
            },
            renderer = {
                root_folder_modifier = ":t",
                icons = {
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_open = "",
                            arrow_closed = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = ""
                        },
                        git = {
                            unstaged = "",
                            staged = "S",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "U",
                            deleted = "",
                            ignored = "◌"
                        }
                    }
                }
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = "󰌶",
                    info = "",
                    warning = "",
                    error = ""
                }
            },
            view = {
                width = 30,
                side = "left"
            },
            actions = {
                open_file = {
                    quit_on_open = true
                }
            }
        })
    end,
}
