return {
    -- Nvim lua API docs and completion
    "folke/lazydev.nvim",
    dependencies = { "Bilal2453/luvit-meta", lazy = true },
    ft = "lua",
    cmd = "LazyDev",
    opts = {
        library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "LazyVim", words = { "LazyVim" } },
            { path = "lazy.nvim", words = { "LazyVim" } },
        }
    }
}
