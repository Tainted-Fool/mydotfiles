-- Use protected call so we know where error is coming from
local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    vim.notify("project plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    vim.notify("telescope plugin was not found!")
    return
end

project.setup({
    active = true,
    on_config_done = nil,
    manual_mode = false,
    detection_methods = {"lsp", "pattern"},
    patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json"}
})

telescope.load_extension("projects")
