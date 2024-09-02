return {
    -- Live markdown previewer
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
        { "<leader>cd", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle (markdown-preview)" },
    },
    ft = { "markdown" },
    build = "cd app && npm install",
    -- build = "cd app && yarn install",
    config = function()
        vim.g.mkdp_auto_close = true
        vim.g.mkdp_open_to_the_world = false
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.g.mkdp_port = "8888"
        vim.g.mkdp_browser = "firefox"
        vim.g.mkdp_echo_preview_url = true
        vim.g.mkdp_page_title = "${name}"
    end
}
