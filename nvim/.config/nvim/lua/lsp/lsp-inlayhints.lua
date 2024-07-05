return {
    -- Shows data type
    "lvimuser/lsp-inlayhints.nvim",
    opts = {
        inlay_hints = {
            parameter_hints = {
                show = true,
                prefix = "<-",
                separator = ", ",
                remove_colon_start = false,
                remove_colon_end = true,
            },
            type_hints = {
                show = true,
                prefix = "->",
                separator = ", ",
                remove_colon_start = true,
                remove_colon_end = false,
            },
            only_current_line = false,
            labels_separator = " ",
            max_len_align = false,
            max_len_align_padding = 1,
            -- right_align = false,
            -- right_align_padding = 7,
            highlight = "LspInlayHint",
        },
        enabled_at_startup = true,
        debug_mode = false,
    },
    config = function(_, opts)
        local inlayhints = require("lsp-inlayhints")
        vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_inlayhints",
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                inlayhints.on_attach(client, bufnr)
            end
        })
        inlayhints.setup(opts)
    end
}
