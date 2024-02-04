-- Options
vim.opt.clipboard:append("unnamedplus") -- setup this way
vim.opt.shortmess:append("c")
vim.cmd("set whichwrap+=<,>[,],h,l") -- or this way
vim.cmd("set iskeyword+=-")

-- Plugin settings - EasyMotion
vim.cmd("map - <Plug>(easymotion-prefix)")
vim.cmd("let g:EasyMotion_disable_two_key_combo = 1")

-- Change default shell to pwsh.exe
vim.cmd([[
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"'
let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
set shellquote= shellxquote=
]])

-- vim.cmd("set shell=pwsh.exe")
-- vim.cmd("set shellcmdflag=-nologo\\ -noprofile\\ -noninteractive\\ -command")
-- vim.cmd("set shell='C:/Program Files/PowerShell/7/pwsh.exe'")
-- vim.cmd("set shellcmdflag=\ -ExecutionPolicy\ RemoteSigned\ -NoProfile\ -NoLogo\ -NonInteractive\ -Command")
-- vim.cmd([[
--    set shell=pwsh.exe
--    set shellcmdflag=-command
--    set shellquote=\"
--    set shellxquote=
-- ]])
-- vim.opt.shell = "pwsh"
-- vim.opt.shellcmdflag = "-NoLogo -NoProfile -NonInteractive -Executionpolicy RemoteSigned -Command $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
-- vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.opt.shellxquote = ""
-- vim.opt.shellquote = ""