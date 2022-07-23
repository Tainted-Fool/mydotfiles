-- Options
vim.opt.clipboard:append("unnamedplus") -- setup this way
vim.opt.shortmess:append("c")
vim.cmd("set whichwrap+=<,>[,],h,l") -- or this way
vim.cmd("set iskeyword+=-")

-- Plugin settings - EasyMotion
vim.cmd("map - <Plug>(easymotion-prefix)")
vim.cmd("let g:EasyMotion_disable_two_key_combo = 1")
