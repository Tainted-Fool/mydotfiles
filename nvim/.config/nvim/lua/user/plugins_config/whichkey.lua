-- Use protected call so we know where error is coming from
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    vim.notify("which-key plugin was not found!")
    return
end

local setup = {
    plugins = {
        marks = true, -- show a list of your marks on ' and `
        registers = true, -- show your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z=
            suggestions = 20
        },
        presets = {
            operators = false, -- adds help for operators like d, y, c, s, etc.
            motions = true, -- adds help for motions
            text_objects = true, -- adds help for text objects triggered after entering an operator
            windows = true, -- default bindings on <C-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    key_labels = {
        -- ["<leader>"] = "SPC"
        -- ["<cr>"] = "ENTER"
    },
    icons = {
        breadcrumbs = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>" -- bindings to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, or shadow
        position = "bottom", -- bottom, or top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = {
            min = 4,
            max = 25
        }, -- min and max height of the columns
        width = {
            min = 20,
            max = 50
        }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left" -- align columns left, center, or right
    },
    ignore_missing = true, -- enable this to hide mappings for these labels
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<cr>", "<CR>", "call", "lua", "^:", "^ "},
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- auto setup triggers
    triggers_blacklist = {
        i = {"j", "k"},
        v = {"j", "k"}
    }
}

local opts = {
    mode = "n", -- trigger only on normal mode
    prefix = "<leader>",
    buffer = nil,
    silent = true, -- use these options when creating keymaps
    noremap = true,
    nowait = true
}

local mappings = {
    ["a"] = {"<cmd>Alpha<cr>", "Alpha Dashboard"},
    -- ["b"] = {
    -- 	"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    -- 	"Buffers",
    -- },
    -- ["b"] = {"<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "File Browser"},
    ["c"] = {"<cmd>Bdelete!<cr>", "Close Buffer"},
    ["e"] = {"<cmd>NvimTreeToggle<cr>", "Explorer"},
    -- ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
    -- ["h"] = { "<cmd>Telescope help_tags<cr>", "Help" },
    ["m"] = {"<cmd>Mason<cr>", "Mason"},
    ["o"] = {"<cmd>Oil<cr>", "Oil"},
    ["P"] = {"<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects"},
    ["q"] = {"<cmd>q!<cr>", "Quit"},
    -- ["W"] = {"<cmd>wq!<cr>", "Save and quit"},
    -- ["x"] = {"<cmd>!chmod +x %<cr>", "Execute"},
    ["x"] = {"<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Telescope Explorer"},
    ["/"] = {"<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "Comment Toggle"},
    ["?"] = {"<cmd>Cheatsheet<cr>", "Cheatsheet"},
    ["-"] = {"<C-W>s", "Split window below"},
    ["\\"] = {"<C-W>v", "Split window right"},

    -- Tmux window navigation
    -- ["C-S-h"] = {"<cmd> TmuxNavigateLeft<cr>", "Window Left"},
    -- ["C-S-l"] = {"<cmd> TmuxNavigateRight<cr>", "Window Right"},
    -- ["C-S-j"] = {"<cmd> TmuxNavigateDown<cr>", "Window Down"},
    -- ["C-S-k"] = {"<cmd> TmuxNavigateUp<cr>", "Window Up"},

    b = {
        name = "Buffer",
        b = {"<cmd>e #<cr>", "Other Buffer"},
        c = {"<cmd>Bdelete!<cr>", "Close Buffer"},
        e = {
            "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
            "Buffer explorer",
        },
        s = {"<cmd>w<cr>", "Save/Write Buffer"},
        q = {"<cmd>wq!<cr>", "Save and Quit Buffer"},
        w = {"<cmd>write<cr>", "Save/Write Buffer"}
    },

    d = {
        name = "Debug",
        b = {"<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint"},
        c = {"<cmd>lua require('dap').continue()<cr>", "Continue"},
        i = {"<cmd>lua require('dap').step_into()<cr>", "Step Into"},
        l = {"<cmd>lua require('dap').run_last()<cr>", "Run Last"},
        o = {"<cmd>lua require('dap').step_over()<cr>", "Step Over"},
        O = {"<cmd>lua require('dap').step_out()<cr>", "Step Out"},
        r = {"<cmd>lua require('dap').repl.toggle()<cr>", "REPL Toggle"},
        t = {"<cmd>lua require('dap').terminate()<cr>", "Terminate"},
        u = {"<cmd>lua require('dapui').toggle()<cr>", "UI Toggle"}
    },

    D = {
        name = "Diagnostics",
        d = {"<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics"},
        l = {"<cmd>TroubleToggle loclist<cr>", "Loclist"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "Quickfix"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
        t = {"<cmd>TroubleToggle<cr>", "Trouble Toggle"},
        w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics"}
    },

    f = {
        name = "Fuzzy Find",
        -- 	f = {
        -- 	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        -- 	"Find Files",
        -- },
        -- f = { "<cmd>lua require('fzf-lua').files()
        -- c = { "<cmd>lua require('fzf-lua').files({cwd= '~/.config'}), "Find Files in .config" },
        c = {"<cmd>FzfLua files cwd=~/.config<cr>", "Find Files in .config"},
        C = {"<cmd>FzfLua colorschemes<cr>", "Find Colorschemes"},
        f = {"<cmd>FzfLua files<cr>", "Find Files"},
        g = {"<cmd>FzfLua git_files<cr>", "Find Git Files"},
        h = {"<cmd>FzfLua command_history<cr>", "Find Command History"},
        H = {"<cmd>FzfLua search_history<cr>", "Find Search History"},
        m = {"<cmd>FzfLua man_pages<cr>", "Find Man Pages"},
        s = {"<cmd>FzfLua spell_suggest<cr>", "Spell Suggestions"}
    },

    g = {
        name = "Git",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout Branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout Commit"},
        d = {"<cmd>Gitsigns diffthis HEAD<cr>", "Diff"},
        f = {"<cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
             "Find Git Files"},
        g = {"<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit"},
        j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
        k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
        l = {"<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame"},
        o = {"<cmd>Telescope git_status<cr>", "Open Changed File"},
        p = {"<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
        r = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
        R = {"<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
        s = {"<cmd>Git<cr>", "Git Status"},
        S = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
        u = {"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk"}
    },

    h = {
        name = "Harpoon",
        a = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Add"},
        m = {"<cmd>Telescope harpoon marks<cr>", "Harpoon Marks"}
        -- m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon Menu" },
    },

    j = {
        name = "Join/Split",
        j = {"<cmd>TSJJoin<cr>", "Join Line"},
        m = {"<cmd>TSJToggle<cr>", "Toggle Node under Cursor"},
        s = {"<cmd>TSJSplit<cr>", "Split Line"}
    },

    l = {
        name = "LSP",
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
        -- d = {
        -- 	"<cmd>Telescope lsp_document_diagnostics<cr>",
        -- 	"Document Diagnostics",
        -- },
        d = {"<cmd>lua require('lsp_lines').toggle()<cr>", "Diagnostics Toggle"},
        D = {"<cmd>DocsViewToggle <cr>", "Documentation toggle"},
        f = {"<cmd>lua vim.lsp.buf.format({async=true})<cr>", "Format"},
        h = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        I = {"<cmd>LspInstallInfo<cr>", "Installer Info"},
        -- j = {
        -- 	"<cmd>lua vim.lsp.diagnostic.goto_next({buffer=0})<cr>",
        -- 	"Next Diagnostic",
        -- },
        -- k = {
        -- 	"<cmd>lua vim.lsp.diagnostic.goto_prev({buffer=0})<cr>",
        -- 	"Prev Diagnostic",
        -- },
        l = {"<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action"},
        o = {"<cmd>SymbolsOutline<cr>", "Symbols Outline Toggle"},
        -- q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
        t = {"<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Inlayhints Toggle"}
        -- w = {
        -- 	"<cmd>Telescope lsp_workspace_diagnostics<cr>",
        -- 	"Workspace Diagnostics",
        -- },
    },

   m = {
        name = "Misc",
        d = {"<cmd>NoiceDismiss<cr>", "Dismiss Noice Message"},
        h = {"<cmd>nohlsearch<cr>", "No Highlight"},
    },

    p = {
        name = "Plugin Manager",
        -- c = {"<cmd>PackerCompile<cr>", "Compile"},
        -- i = {"<cmd>PackerInstall<cr>", "Install"},
        l = {"<cmd>Lazy<cr>", "Lazy"},
        -- s = {"<cmd>PackerSync<cr>", "Sync"},
        -- S = {"<cmd>PackerStatus<cr>", "Status"},
        -- u = {"<cmd>PackerUpdate<cr>", "Update"}
        u = {"<cmd>Lazy<cr>", "Update"}
    },

    r = {
        name = "Run",
        m = {"<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview"},
        o = {"<cmd>source ~/.config/nvim/lua/user/luasnip.lua<cr>", "Source Snippets"},
        p = {"<cmd>Lab code run<cr>", "Code Preview"},
        r = {"<cmd>w | Jaq<cr>", "Run"},
        s = {"<cmd>Lab code stop<cr>", "Code Preview Stop"},
        x = {"<cmd>!chmod +x %<cr>", "Add Execute Bit"},
    },

    s = {
        name = "Search",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout Branch"},
        B = {"<cmd>Telescope buffers<cr>", "Buffers"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        C = {"<cmd>Telescope commands<cr>", "Commands"},
        f = {":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search and Replace"},
        F = {"<cmd>Telescope find_files<cr>", "Find Files"},
        g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        p = {"<cmd>Telescope projects<cr>", "Projects"},
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        s = {"<cmd>Telescope session-lens search_session<cr>", "Search Sessions"},
        S = {"<cmd>SaveSession<cr>", "Save Sessions"}
    },

    t = {
        name = "Terminal",
        f = {"<cmd>ToggleTerm direction=float<cr>", "Float"},
        h = {"<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal"},
        n = {"<cmd>lua _NODE_TOGGLE()<cr>", "Node"},
        p = {"<cmd>lua _PYTHON_TOGGLE()<cr>", "Python"},
        t = {"<cmd>lua _HTOP_TOGGLE()<cr>", "HTop"},
        u = {"<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU - Disk Usage"},
        v = {"<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical"}
    },

    w = {
       name = "Windows",
        c = {"<C-W>c", "Close window"},
        d = {"<C-W>c", "Delete window"},
        o = {"<C-W>o", "Close all other windows"},
        s = {"<C-W>s", "Split window below"},
        v = {"<C-W>v", "Split window right"},
        w = {"<C-W>w", "Switch window"}
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)

-- Change default background color
vim.cmd([[hi WhichKeyFloat ctermfg=grey]])
