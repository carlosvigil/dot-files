return {
	"rebelot/kanagawa.nvim",
	lazy = false, -- make sure we load this during startup
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function() require('kanagawa').setup({
		transparent = true,
		commentStyle = { italic = false },
		functionStyle = { italic = true },
	}) end,
	init = function()
		vim.cmd.colorscheme('kanagawa-dragon')
	end,
}
