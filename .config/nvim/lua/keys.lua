VKS = vim.keymap.set

vim.g.mapleader = " "

-- Finger Savers Prime
VKS('i', 'kj', '<Esc>')
VKS('n', '<leader><leader>', ':', { desc = 'Command' })

-- Write & Quit
VKS('n', '<leader>s', vim.cmd.write, { desc = 'Write/Save' })
VKS('n', '<leader>qq', vim.cmd.quit, { desc = 'Quit' })
VKS('n', '<leader>qa', vim.cmd.quitall, { desc = 'Quit All' })
VKS('n', '<leader>qQ', function() vim.cmd('q!') end,
  { desc = 'Force Quit' })
VKS('n', '<leader>qA', function() vim.cmd('qa!') end,
  { desc = 'Force Quit All (ZQ)' })
VKS('n', '<leader>qs', function() vim.cmd('wqall') end,
  { desc = 'Write All & Quit (ZZ)' })

-- Buffer
VKS('n', '<leader>h', vim.cmd.bdelete, { desc = 'Buffer Delete' })
VKS('n', '<Tab>', vim.cmd.bNext, { desc = 'Buffer Next' })

-- Window
VKS('n', '<leader>w', '<c-w>', { remap = true, desc = 'Window' })

-- Tools
VKS('n', '<leader>S', function() require('mini.starter').open() end,
  { desc = 'Starter' })
VKS('n', '<leader>n', vim.cmd.Ex, { desc = 'Netrw' })
VKS('n', '<leader>p', vim.cmd.Lazy, { desc = 'Plugins' })

-- Humanist Motions Department
VKS("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line(s) down' })
VKS("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line(s) up' })

VKS("n", "J", "mzJ`z", { desc = 'Join line, keep cursor' })

VKS('n', 'j', 'jzz')
VKS('n', 'k', 'kzz')
VKS("n", "<C-d>", "<C-d>zz")
VKS("n", "<C-u>", "<C-u>zz")
VKS("n", "n", "nzzzv", { desc = 'Next search result, center view' })
VKS("n", "N", "Nzzzv", { desc = 'Previous search result, center view' })
