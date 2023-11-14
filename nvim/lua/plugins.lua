return {
-- Words

{ 'neovim/nvim-lspconfig'
},

{ 'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function ()
		require('nvim-treesitter.configs').setup({
			ensure_installed = 'all',
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = {
				enable = true
			},
		})
	end
},

{ 'echasnovski/mini.surround',
	version = false,
	config = true
},

-- Navigation

{ 'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	event = 'BufRead',
	cmd = 'Telescope',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'theprimeagen/harpoon',
		'nvim-treesitter/nvim-treesitter',
		'neovim/nvim-lspconfig',
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake',
		config = function()
			require('telescope').load_extension('telescope-fzf-native.nvim')
		end,
	},
	opts = {
		defaults = {
			file_ignore_patterns = {
				'%.git', 'node_modules', 'venv', '.venv', 'env', '.env'
			},
		},
		pickers = {
			find_files = {
				find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
			},
		},
		extensions = {
			'fzf',
			'harpoon'
		}
	},
	keys = {
		{
			'<leader>ff',
			function()
				require('telescope.builtin').find_files()
			end, {},
			desc = 'Find files',
		},
		{
			'<leader>fg',
			function()
				require('telescope.builtin').git_files()
			end, {},
			desc = 'Find git files',
		},
		{
			'<leader>fb',
			function()
				require('telescope.builtin').buffers()
			end, {},
			desc = 'Find buffers',
		},
		{
			'<leader>fh',
			function()
				require('telescope.builtin').help_tags()
			end, {},
			desc = 'Find help tags',
		},
		{
			'<leader>fw',
			function() 
				require('telescope.builtin').grep_string({
					search = vim.fn.input('grep > ')
				})
			end,
			desc = 'Find word'
		}
	}
},

{ 'theprimeagen/harpoon',
	event = 'VeryLazy',
	dependencies =	{ 'nvim-lua/plenary.nvim' },
	keys = {
		{
			'<leader>j', function() require('harpoon.mark').add_file() end,
			desc = 'Hook file',
		},
		{
			'<leader>h', function() require('harpoon.ui').toggle_quick_menu() end,
			desc = 'Harpoon Menu',
		},
		{
			'<leader>n', function() require('harpoon.ui').nav_next() end,
			desc = 'Go to next Hook',
		},
		{
			'<leader>1', function() require('harpoon.ui').nav_file(1) end,
			desc = 'Go to Hook 1',
		},
		{
			'<leader>2', function() require('harpoon.ui').nav_file(2) end,
			desc = 'Go to Hook 2',
		},
		{
			'<leader>3', function() require('harpoon.ui').nav_file(3) end,
			desc = 'Go to Hook 3',
		},
		{
			'<leader>t', function() require('harpoon.term').gotoTerminal(1) end,
			desc = 'Go to Terminal',
		},
	},
	opts = {
		global_settings = {
			mark_branch = true
		},
		menu = {
			width = vim.api.nvim_win_get_width(0) - 8,
			height = 5
		}
	}
},

{ 'folke/which-key.nvim',
	event = 'VeryLazy',
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 200
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
},

{ 'karb94/neoscroll.nvim', init = function() require('neoscroll').setup() end },

-- Utilities

{ 'tpope/vim-fugitive',
	event = 'VeryLazy',
	keys = {
		{ '<leader>gs', '<cmd>vim.cmd.Git<cr>', desc = 'Git Status' }
	}
},

{ 'mbbill/undotree',
	event = 'VeryLazy',
	cmd = 'UndotreeToggle',
	keys = { 
		{ '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Undo Tree' } 
	}
},

-- LOOKS

{ 'nvim-tree/nvim-web-devicons', lazy = true },

{ 'rebelot/kanagawa.nvim',
	lazy = false, -- make sure we load this during startup
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function() require('kanagawa').setup({
		compile = false,
		undercurl = true,
		transparent = true,
		commentStyle = { italic = false },
		functionStyle = { italic = true },
		statementStyle = { bold = true },
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none"
					}
				}
			}
		},
		overrides = function(colors)
			local theme = colors.theme
			return {
				TelescopeTitle = { fg = theme.ui.special, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
			}
		end,
	}) end,
	init = function()
		vim.cmd.colorscheme('kanagawa-dragon')
	end,
},

{ 'HiPhish/rainbow-delimiters.nvim',
	config = function() 
		local rainbow_delimiters = require 'rainbow-delimiters'

		vim.g.rainbow_delimiters = {
			strategy = {
				[''] = rainbow_delimiters.strategy['global'],
			},
			query = {
				[''] = 'rainbow-delimiters',
				lua = 'rainbow-blocks',
			},
			highlight = colors_indent_delimiters
		}
	end
},

{ 'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	config = function()
		local highlight = colors_indent_delimiters

		local hooks = require('ibl.hooks')
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, 'dragonRed', { fg = '#c4746e' })
			vim.api.nvim_set_hl(0, 'dragonBlue', { fg = '#8ba4b0' })
			vim.api.nvim_set_hl(0, 'dragonYellow', { fg = '#c4b28a' })
			vim.api.nvim_set_hl(0, 'dragonGreen', { fg = '#87a987' })
			vim.api.nvim_set_hl(0, 'dragonViolet', { fg = '#8992a7' })
			vim.api.nvim_set_hl(0, 'dragonOrange', { fg = '#b6927b' })
			vim.api.nvim_set_hl(0, 'dragonCyan', { fg = '#949fb5' })
		end)

		require('ibl').setup({
			indent = { highlight = highlight },
			scope = { highlight = highlight }
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end
}
-- outdented final curly
}
