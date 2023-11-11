vim.g.loaded_perl_provider = 0
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- mouse in all modes
vim.opt.mouse = 'a'
-- hover on bufferline
vim.opt.mousemoveevent = true

vim.opt.hlsearch = false
vim.opt.smartcase = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.tabstop = 3

vim.opt.bs = 'start'

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

