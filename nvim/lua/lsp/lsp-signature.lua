return {
    -- better signature help
    "ray-x/lsp_signature.nvim",
    opts = {
        -- floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
        -- floating_window_above_cur_line = false, -- try to place the floating above the current line when possible
        hint_prefix = "💀 ", -- Skull emoji for parameter
        -- hint_scheme = "Comment", -- or 'String'
        -- use_lspsaga = false, -- set to true if you want to use lspsaga popup
        toggle_key = "<C-\\>",
        select_signature_key = "<C-]>",
    },
    config = function(_, opts)
        require("lsp_signature").setup(opts)
    end
}
