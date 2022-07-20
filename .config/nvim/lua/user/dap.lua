-- Use protected call so we know where error is coming from
local status_ok, dap = pcall(require, "dap")
if not status_ok then
    vim.notify("dap plugin was not found!")
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    vim.notify("dapui plugin was not found!")
    return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
    vim.notify("dap-install plugin was not found!")
    return
end

dap_install.setup {}

dap_install.config("python", {})
-- Add other configs here

dapui.setup{
    icons = {expanded = "▾", collapsed = "▸"},
    mappings = {
        -- Use a table to apply multiple mappings
        expand = {
            "<CR>",
            "<2-LeftMouse>"
        },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t"
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.25
                },
                "breakpoints",
                "stacks",
                "watches"
            },
            size = 40, -- 40 columns
            position = "left"
        },
        {
            elements = {
                "repl",
                "console"
            },
            size = 0.25, -- 25% of total lines
            position = "bottom"
        }
    },
    floating = {
        max_height = nil, -- these can be integers or a float between 0 and 1
        max_width = nil, -- floats will be treated as percentage of your screen
        border = "rounded", -- border style. Can be "single", "double" or "rounded"
        mappings = {
            close = {
                "q",
                "<Esc>"
            }
        }
    },
    windows = {indent = 1},
    render = {
        max_type_length = nil -- can be integer or nil
    }
}


vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = ""
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end