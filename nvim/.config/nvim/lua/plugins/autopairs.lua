return {
    -- Autopairs auto-completion and indentation
    'windwp/nvim-autopairs',
    event = "InsertEnter",

    opts = {
        enable_check_bracket_line = false, -- check bracket in same line
        check_ts = true, -- treesitting integration
        ts_config = {
            lua = {"string", "source"},
            javascript = {"string", "template_string"},
            java = false
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" }, -- disable autopairs for these filetypes
        fast_wrap = {
            map = "<M-e>", -- Alt+e then `$` to move to end
            chars = {"{", "[", "(", '"', "'"},
            pattern = [=[[%'%"%>%]%)%}%,]]=],
            end_key = "$",
            before_key = "h",
            after_key = "l",
            cursor_pos_before = true,
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            manual_position = true,
            highlight = "Search",
            highlight_grey = "Comment"
        }
        ,
        config = function(_, opts)

            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            require("nvim-autopairs").setup(opts)

            -- Add autopairs to atuo-completion
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    }
}
