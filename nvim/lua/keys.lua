VKS = vim.keymap.set

vim.g.mapleader = " "

-- Finger Savers Prime
VKS('i', 'kk', '<Esc>')
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
VKS('n', '<leader>d', vim.cmd.bdelete, { desc = 'Buffer Delete' })
VKS('n', '<Tab>', vim.cmd.bnext, { desc = 'Buffer Next' })
VKS('n', '<S-Tab>', vim.cmd.bprevious, { desc = 'Buffer Previous' })

-- Window
VKS('n', '<leader>w', '<c-w>', { remap = true, desc = 'Window' })

-- Tools
-- VKS('n', '<leader>S', function() require('mini.starter').open() end,
	-- { desc = 'Starter' })
VKS('n', '<leader>m', ':Lex<CR>:vertical resize 30<CR>', { desc = 'Netrw' })
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

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
