return {
    -- Debug adapter protocol
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
        { "<leader>d", "", desc = "debug" },
        { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint (dap)" },
        { "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Breakpoint Condition (dap)" },
        { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue (dap)" },
        { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into (dap)" },
        { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", desc = "Run Last (dap)" },
        { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over (dap)" },
        { "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out (dap)" },
        { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "REPL Toggle (dap)" },
        { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate (dap)" },
        { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "UI Toggle (dap)" },
    },
    dependencies = {
        "rcarriga/nvim-dap-ui", -- debugger ui
        "mfussenegger/nvim-dap-python", -- dap for python
        { "thehamsta/nvim-dap-virtual-text", opts = { commented = true } }, -- virtual text for dap
        "nvim-neotest/nvim-nio",
        {
            "rcarriga/cmp-dap",
            dependencies = { "nvim-cmp" },
            config = function()
                require("cmp").setup.filetype(
                    {
                        "dap-repl",
                        "dapui_watches",
                        "dapui_hover",
                    },
                    {
                        sources = {
                            { name = "dap" }
                        }
                    }
                )
            end
        }
    },
    config = function()
        local icons = require("core.icons")
        local windows = vim.fn.has("win32") == 1 -- true if on windows
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")
        dapui.setup({
            expand_lines = true,
            icons = {
                expanded = icons.misc.Expanded,
                collapsed = icons.misc.Collapsed,
                circular = icons.misc.Circular,
            },
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.33,
                        },
                        {
                            id = "breakpoints",
                            size = 0.17,
                        },
                        {
                            id = "stacks",
                            size = 0.25,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        }
                    },
                    size = 0.33,
                    position = "left",
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.65,
                        },
                        {
                            id = "console",
                            size = 0.35,
                        }
                    },
                    size = 0.27,
                    position = "bottom",
                }
            },
            floating = {
                max_height = 0.9,
                max_width = 0.5,
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            }
        })
        vim.fn.sign_define("DapBreakpoint", {
            text = icons.ui.Bug,
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
        })
        -- DAP settings for python
        -- dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        -- RUN THESE COMMANDS
        -- mkdir .virtualenvs
        -- cd .virtualenvs
        -- python -m venv debugpy
        -- debugpy/bin/python -m pip install debugpy
        -- END
        dap_python.setup("~/.virtualenvs/debugpy/bin/python")
        -- dap_python.setup()
        -- DAP settings for bash
        dap.adapters.bashdb = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
            name = "bashdb",
        }
        dap.configurations.sh = {
            {
                type = "bashdb",
                request = "launch",
                name = "Launch file",
                showDebugOutput = true,
                pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
                pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
                trace = true,
                file = "${file}",
                program = "${file}",
                cwd = "${workspaceFolder}",
                pathCat = "cat",
                pathBash = "/bin/bash",
                pathMkfifo = "mkfifo",
                pathPkill = "pkill",
                args = {},
                env = {},
                terminalKind = "integrated",
            }
        }
        -- DAP settings for c
        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
            detached = function()
                if windows then
                    return false
                else
                    return true
                end
            end
        }
        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            }
        }
        -- DAP settings for cplusplus
        dap.configurations.cpp = dap.configurations.c
        -- DAP settings for csharp
        dap.adapters.coreclr = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
            args = {"--interpreter=vscode"},
        }
        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                end
            }
        }
        -- DAP settings for rust
        -- dap.configurations.rust = dap.configurations.c
        dap.configurations.rust = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                sourceLanguages = { "rust" }
            }
        }
        -- Open dapui when dap in initialized
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        -- Close dapui when dap is terminated
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        -- Close dapui when dap is exited
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
