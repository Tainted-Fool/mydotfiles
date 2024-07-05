return {
    -- Better signature help
    "ray-x/lsp_signature.nvim",
    opts = {
        -- doc_lines = 0, -- show lines of comment/docs
        floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible
        hint_enable = true,
        hint_prefix = "💀 ", -- Skull emoji for parameter
        -- hint_scheme = "Comment", -- 'Comment' or 'String'
        -- use_lspsaga = false, -- set to true if you want to use lspsaga popup
        toggle_key = "<C-s>", -- toggle signature help window
        select_signature_key = "<C-]>", -- select the next signature if available
        cursorhold_update = false, -- fix jedi_ls on empty line
    },
    config = function(_, opts)
        require("lsp_signature").setup(opts)
    end
}
