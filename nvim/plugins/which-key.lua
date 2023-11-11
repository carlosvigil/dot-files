return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		require('which-key').register({
			f = { name = 'Find' },
			g = { name = 'Git' },
			q = { name = 'Quit' },
		}, { prefix = '<leader>' })
	end,
	opts = {
		window = {
			winblend = 20
		},
		layout = {
			spacing = 2,
			align = 10
		},
	},
	config = {
	}
}
