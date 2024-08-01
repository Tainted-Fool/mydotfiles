return {
     -- Mark and get file
    "theprimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    keys = {
        { "<leader>h", "", desc = "harpoon" },
        { "<leader>ha", "<cmd>lua require('harpoon'):list():append()<cr>", desc = "Add (Harpoon)" },
        { "<leader>hl", "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>", desc = "List (Harpoon)" },
        { "<leader>hm", "<cmd>Telescope harpoon marks<cr>", desc = "Marks (Harpoon)" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})
        -- Basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end
            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end
        vim.keymap.set("n", "<C-s>", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open Harpoon Window" })
    end
}
