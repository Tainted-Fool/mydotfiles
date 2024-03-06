-- Use protected call so we know where error is coming from
local status_ok, session = pcall(require, "auto-session")
if not status_ok then
    vim.notify("auto-session plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    vim.notify("telescope plugin was not found!")
    return
end

-- Use protected call so we know where error is coming from
local lens_ok, lens = pcall(require, "session-lens")
if not lens_ok then
    vim.notify("session-lens plugin was not found!")
    return
end

-- Recommended session options configurations
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

telescope.load_extension("session-lens")

lens.setup({
    path_display = {"shorten"},
    theme_conf = {
        border = false
    },
    previewer = true,
    prompt_title = "Sessions"
})

session.setup({
    log_level = "error",
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = {os.getenv("HOME") -- if neovim is opened from $HOME, then DO NOT restore session
    },
    auto_session_use_git_branch = nil,
    bypass_session_save_file_types = {"alpha"}
})
