return {
    -- add highlights to buffers
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      -- Create a table for each filetype
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        -- Set options for each filetype
        opts[ft] = {
          headline_highlights = {},
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        }
        -- Set the headlines groups for each filetype
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- Define custom highlight groups using Vimscript
      vim.cmd([[highlight Headline1 guibg=#295715 guifg=white]])
      vim.cmd([[highlight Headline2 guibg=#8d8200 guifg=white]])
      vim.cmd([[highlight Headline3 guibg=#a56106 guifg=white]])
      vim.cmd([[highlight Headline4 guibg=#7e0000 guifg=white]])
      vim.cmd([[highlight Headline5 guibg=#1e0b7b guifg=white]])
      vim.cmd([[highlight Headline6 guibg=#560b7b guifg=white]])
      -- Defines the codeblock background color to something darker
      vim.cmd([[highlight CodeBlock guibg=#09090d]])

      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
}
