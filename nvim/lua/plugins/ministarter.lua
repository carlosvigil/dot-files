return {
	"echasnovski/mini.starter",
	version = false,
	event = "VimEnter",
	config = function()
		local starter = require("mini.starter")

		starter.setup({
			items = {
				{ name = "Open Old Files", action = "Telescope oldfiles", section = "File Explorer" },
				{ action = starter.sections.recent_files(5, true, true), section = "Recent Files" },
				{ name = "Quit Neovim", action = "quitall", section = "Manage Neovim" },
				{ name = "Update Plugins", action = "Lazy sync", section = "Manage Neovim" },
			},
			header = 'Neovim',
			footer = 'Leader key is <space>',
		})
	end,
}