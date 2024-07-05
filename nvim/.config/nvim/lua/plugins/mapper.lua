return {
    -- Map keys with telescope
    "gregorias/nvim-mapper",
    enabled = false, -- disable plugin
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        require("nvim-mapper").setup({
            no_map = true, -- map to <leader>MM
        })
    end
}
