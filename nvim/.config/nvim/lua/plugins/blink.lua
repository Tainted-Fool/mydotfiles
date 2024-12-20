return {
    -- completion plugin
    "saghen/blink.cmp",
    enabled = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
        keymap = {
            ["<Tab>"] = { "select_next", "fallback" }, -- snippets
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<C-y>"] = { "accept", "fallback" },
            ["<C-e>"] = { "cancel", "fallback" },
            ["<C-l>"] = { "show", "hide", "fallback" },
            ["<C-Space>"] = { "show_documentation", "hide_documentation", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        },
        completion = {
            list = { selection = "auto_insert" },
            accept = {
                auto_brackets = {
                    enabled = false
                }
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
            },
            menu = {
                draw = {
                    columns = {
                        {
                            "label",
                            "label_description",
                            gap = 1
                        },
                        {
                            "kind"
                        }
                    }
                }
            }
        }
    }
}
