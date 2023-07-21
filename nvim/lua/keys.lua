vim.g.mapleader = " "

VKS = vim.keymap.set

VKS('i', 'kj', '<Esc>')
VKS('n', '<leader><leader>', ':', { desc = 'Command'})
VKS('n', '<leader>s', vim.cmd.w, { desc = 'Write/Save'})
VKS('n', '<leader>qq', vim.cmd.quit, { desc = 'Quit'})
VKS('n', '<leader>qa', vim.cmd.quitall, { desc = 'Quit All'})
VKS('n', '<leader>h', vim.cmd.bdelete, { desc = 'Buffer Delete'})
VKS('n', '<Tab>', vim.cmd.bNext, { desc = 'Buffer Next'})

VKS('n', '<leader>n', vim.cmd.Ex, { desc = 'Netrw'})
VKS('n', '<leader>p', vim.cmd.Lazy, { desc = 'Plugins'})

VKS("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line(s) down'})
VKS("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line(s) up'})

VKS("n", "J", "mzJ`z", { desc = 'Join line, keep cursor'})

VKS('n', 'j', 'jzz')
VKS('n', 'k', 'kzz')
VKS("n", "<C-d>", "<C-d>zz")
VKS("n", "<C-u>", "<C-u>zz")
VKS("n", "n", "nzzzv", { desc = 'Next search result, center view'})
VKS("n", "N", "Nzzzv", { desc = 'Previous search result, center view'})
