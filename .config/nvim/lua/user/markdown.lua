-- Use protected call so we know where error is coming from
local status_ok, markdown = pcall(require, "markdown")
if not status_ok then
    vim.notify("nvim-markdown plugin was not found!")
    return
end

vim.cmd[[
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_conceal_code_blocks = 0
    let g:vim_markdown_fenced_languages = ['bash=sh', 'csharp=cs', 'css', 'html', 'javascript', 'js=javascript', 'python', 'xml', 'yaml', 'pwsh=powershell', 'lua']
]]