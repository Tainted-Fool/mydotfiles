-- Use protected call so we know where error is coming from
local copilot_ok, copilot = pcall(require, "copilot")
if not copilot_ok then
    vim.notify("copilot plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local co_cmp_ok, co_cmp = pcall(require, "copilot_cmp")
if not co_cmp_ok then
	vim.notify("copilot-cmp plugin was not found!")
	return
end

-- Setup copilot
copilot.setup({
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>"
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = true,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 18.x
    server_opts_overrides = {},
  })

-- Setup cmp source
co_cmp.setup({})