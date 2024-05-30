return {
    -- debug adapter protocol
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui", -- debugger ui
        "mfussenegger/nvim-dap-python", -- dap for python
        { "thehamsta/nvim-dap-virtual-text", opts = {commented = true} }, -- virtual text for dap
        "nvim-neotest/nvim-nio", -- dependency for nvim-dap
    },
    {
        "rcarriga/cmp-dap",
        dependencies = { "nvim-cmp" },
        config = function()
            require("cmp").setup.filetype(
                { "dap-repl", "dapui_watches", "dapui_hover" },
                {
                    sources = {
                        { name = "dap" },
                    },
                }
            )
        end,
    },
    config = function()
        local windows = vim.fn.has('win32') == 1 -- true if on windows
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")

        dapui.setup({
            expand_lines = true,
            icons = {
                expanded = "",
                collapsed = "",
                circular = ""
            },
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t"
            },
            layouts = { {
                elements = { {
                    id = "scopes",
                    size = 0.33
                }, {
                    id = "breakpoints",
                    size = 0.17
                }, {
                    id = "stacks",
                    size = 0.25
                }, {
                    id = "watches",
                    size = 0.25
                } },
                size = 0.33,
                position = "left"
            }, {
                elements = { {
                    id = "repl",
                    size = 0.45
                }, {
                    id = "console",
                    size = 0.55
                } },
                size = 0.27,
                position = "bottom"
            } },
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
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = ""
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
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath('data') .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
                detached = function() if windows then return false else return true end end,
            }
        }
        dap.configurations.c = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            },
        }

        -- DAP settings for cplusplus
        dap.configurations.cpp = dap.configurations.c

        -- DAP settings for csharp
        dap.adapters.coreclr = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
            args = { "--interpreter=vscode" },
        }
        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            },
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
