return {
    -- home page
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    lazy = true,

    opts = function()

        local dashboard = require("alpha.themes.dashboard")

        local logo = [[
            ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
            ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
            ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
            ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
            ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
            ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
        ]]

        dashboard.section.header.val = vim.split(logo, "\n")

        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find File", ":Telescope find_files hidden=true<CR>"),
            dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", "  Find Project", ":Telescope projects <CR>"),
            dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>")
        }

        dashboard.section.header.opts.hl = "Function"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.section.footer.opts.hl = "Special"
        return dashboard
    end,
    config = function(_, dashboard)
        -- dashboard.opts.opts.noautocmd = true
        -- alpha.setup(dashboard.opts)

        -- close lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        -- setup alpha dashboard
        require("alpha").setup(dashboard.opts)

        -- setup fortune-mod
        local function footer()
            -- need fortune-mod -> sudo apt install fortune-mod
            local handle = io.popen("fortune")
            if not handle then
                vim.notify("Fortune-mod not installed")
                vim.notify("Run `sudo apt install fortune-mod`")
                return
            end

            local fortune = handle:read("*a")
            handle:close()
            return fortune
        end

        -- Display fortune-mod and startuptime
        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded "
                    .. stats.loaded
                    .. "/"
                    .. stats.count
                    .. " plugins in "
                    .. ms
                    .. "ms"
                    .. "\n"
                    .. footer()
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
