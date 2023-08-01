return {
	"rebelot/kanagawa.nvim",
	lazy = false, -- make sure we load this during startup
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function() require('kanagawa').setup({
		compile = false,
		undercurl = true,
		commentStyle = { italic = false },
		functionStyle = { italic = true },
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false,
		dimInactive = false,
		terminalColors = true,
		colors = {
			palette = {},
			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
		},
		overrides = function(colors)
			return {}
		end,
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus"
		},
	}) end,
	init = function()
		vim.cmd.colorscheme('kanagawa')
	end,
}
