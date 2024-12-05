return {
    "marcussimonsen/let-it-snow.nvim",
    cmd = "LetItSnow",
    keys = {
        { "<leader>Gs", "<cmd>LetItSnow<cr>", desc = "Snow (let-it-snow)" },
    },
    config = true,
    opts = {
        delay = 250,
        max_spawn_attempts = 250,
        snowflake_char = "\u{2745}",
    }
}
