vim.g.mapleader = " "

VKS = vim.keymap.set

VKS('i', 'kj', '<Esc>')

VKS("n", "<leader>n", vim.cmd.Ex, { desc = 'Netrw'})

VKS("v", "J", ":m '>+1<CR>gv=gv")
VKS("v", "K", ":m '<-2<CR>gv=gv")

VKS("n", "J", "mzJ`z")

VKS('n', 'j', 'jzz')
VKS('n', 'k', 'kzz')
VKS("n", "<C-d>", "<C-d>zz")
VKS("n", "<C-u>", "<C-u>zz")
VKS("n", "n", "nzzzv")
VKS("n", "N", "Nzzzv")
