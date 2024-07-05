return {
    -- Code Runner for js, ts, lua, and python
    "0x100101/lab.nvim",
    build = "cd js && npm ci",
    event = "VeryLazy",
    opts = {
        code_runner = {
            enabled = true,
        },
        quick_data = {
            enabled = false,
        }
    }
}
