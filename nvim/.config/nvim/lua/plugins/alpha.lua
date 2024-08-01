return {
    -- Dashboard
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true, -- load after everything else
    event = "VimEnter",
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local icons = require("core.icons")

    --     local logo = [[
    -- 🛸　　　 　🌎　°　　🌓　•　　.°•　　　🚀 ✯ ,
    -- 　　　★　*　　　　　°　　　　🛰 　°·      🪐,
    -- .　　　•　° ★　•  ☄                        ,
    --                ▁▂▃▄▅▆▇▇▆▅▄▃▂▁.           ,
    --     ]]

        -- local logo = [[
        --     ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
        --     ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
        --     ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
        --     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
        --     ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
        --     ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
        -- ]]

        local logo = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]]

        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
            dashboard.button("c", icons.kind.Constructor  .. "  Configuration", ":e $MYVIMRC <CR>"),
            dashboard.button("e", icons.misc.Explorer .. "  File Explorer", ":Oil <CR>"),
            dashboard.button("f", icons.ui.FindFile .. "  Find File", ":Telescope find_files hidden=true<CR>"),
            dashboard.button("n", icons.ui.NewFile .. "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", icons.ui.Project .. "  Find Project", ":Telescope projects <CR>"),
            dashboard.button("q", icons.misc.Quit .. "  Quit", ":qa<CR>"),
            dashboard.button("r", icons.ui.RecentFiles .. "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", icons.ui.FindText .. "  Find Text", ":Telescope live_grep <CR>"),
        }
        dashboard.section.header.opts.hl = "Function"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.section.footer.opts.hl = "Special"
        return dashboard
    end,
    config = function(_, dashboard)
        -- Close lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end
            })
        end

        -- Setup fortune-mod
        local function footer()
            local handle = io.popen("fortune")-- sudo apt install fortune-mod
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
            end
        })

        require("alpha").setup(dashboard.opts)
    end
}
