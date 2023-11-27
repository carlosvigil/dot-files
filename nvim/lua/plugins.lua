return {
-- WORDS

{ 'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',

		-- lsp updates?
		{ 'j-hui/fidget.nvim', opts = {} },

		-- lua stuff?
		{ 'folke/neodev.nvim', opts = {} },

		-- TODO: read these readmes
		{ 'hrsh7th/nvim-cmp',
			dependencies = {
				-- Snippet Engine & its associated nvim-cmp source
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',

				-- Adds LSP completion capabilities
				'hrsh7th/cmp-nvim-lsp',

				-- Adds a number of user-friendly snippets
				'rafamadriz/friendly-snippets',
			},
		},
	},
	config = function()
		--	This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = 'LSP: ' .. desc
				end

				VKS('n', keys, func, { buffer = bufnr, desc = desc })
			end

			nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
			nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode Action')

			nmap('[d', vim.diagnostic.goto_prev)
			nmap(']d', vim.diagnostic.goto_next)

			nmap('<leader>lf', vim.diagnostic.open_float, 'Float diag.')
			nmap('<leader>lF', vim.lsp.buf.format, 'Format buffer')
			nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
			nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
			nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
			nmap('<leader>lwl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, '[W]orkspace [L]ist Folders')

			nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
			nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
			nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

			-- See `:help K` for why this keymap
			nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
			nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' })
		end
		--
		-- document existing key chains
		require('which-key').register {
			['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
			['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
			['<leader>ld'] = { name = 'Document', _ = 'which_key_ignore' },
			['<leader>lw'] = { name = 'Workspace', _ = 'which_key_ignore' },
		}

		require('mason').setup()
		require('mason-lspconfig').setup()

		-- Enable the following language servers
		local servers = {
			gopls = {},
			rust_analyzer = {},
			jsonls = {},
			eslint = {},
			tsserver = {},
			html = { filetypes = { 'html', } },
			svelte = {},
			bashls = {},
			dockerls = {},
			docker_compose_language_service = {},
			cssls = {},
			tailwindcss = {},
			taplo = {},
			marksman = {},
			pyright = {},
			ruff_lsp = {},

			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		}

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- Ensure the servers above are installed
		local mason_lspconfig = require 'mason-lspconfig'

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}

		-- [[ Configure nvim-cmp ]]
		-- See `:help cmp`
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup {}

		cmp.setup {
			snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
			},
			completion = {
				completeopt = 'menu,menuone,noinsert'
			},
			mapping = cmp.mapping.preset.insert {
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		}
	end,
},

{ 'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
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
	config = function()
		require 'mini.surround'.setup {
			mappings = {
				add = 'csa',
				delete = 'csd',
				replace = 'csr',
			}
		}
	end
},

{ 'numToStr/Comment.nvim',
	opts = {}
},

-- NAVIGATION
{ 'ggandor/leap.nvim',
	config = function()
		require('leap').add_default_mappings(true)
	end
},

-- TODO: add shortcut, neotree
{ "nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	}
},

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
			{ 'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
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
				require ('telescope.builtin').find_files()
			end, {},
			desc = 'Find files',
		},
		{
			'<leader>fg',
			function()
				require ('telescope.builtin').git_files()
			end, {},
			desc = 'Find git files',
		},
		{
			'<leader>fr',
			function ()
				require ('telescope.builtin').oldfiles()
			end, {},
			desc = 'Find recent files'
		},
		{
			'<leader>fb',
			function()
				require ('telescope.builtin').buffers()
			end, {},
			desc = 'Find buffers',
		},
		{
			'<leader>fh',
			function()
				require ('telescope.builtin').help_tags()
			end, {},
			desc = 'Find help tags',
		},
		{
			'<leader>fd',
			function()
				require ('telescope.builtin').diagnostics()
			end, {},
			desc = 'Find in diagnostics',
		},
		{
			'<leader>fw',
			function()
				require ('telescope.builtin').grep_string({
					search = vim.fn.input('grep > ')
				})
			end,
			desc = 'Find word'
		},
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
				c = { name = 'Config' },
				f = { name = 'Find' },
				g = { name = 'Git' },
				q = { name = 'Quit' },
			}, { prefix = '<leader>' }
		)

		require('which-key').register({
			['cs'] = { name = 'Change surround' },
		})
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

	-- TODO: Add shortcut, todo comments
{ 'folke/todo-comments.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {}
},

{ 'karb94/neoscroll.nvim', init = function() require('neoscroll').setup() end },

-- UTILITIES

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

{ 'nvim-lualine/lualine.nvim',
	opts = {
		extensions = { 'mason', 'fzf', 'lazy', 'fugitive' },
	},
},

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
		vim.cmd.colorscheme('kanagawa-wave')
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
},

-- Adds git related signs to the gutter, as well as utilities for managing changes
{ 'lewis6991/gitsigns.nvim',
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},

		on_attach = function(bufnr)
			vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

			-- don't override the built-in and fugitive keymaps
			local gs = package.loaded.gitsigns

			vim.keymap.set({ 'n', 'v' }, ']c', function()
				if vim.wo.diff then
					return ']c'
				end
				vim.schedule(function()
					gs.next_hunk()
				end)

				return '<Ignore>'
			end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })

			vim.keymap.set({ 'n', 'v' }, '[c', function()
				if vim.wo.diff then
					return '[c'
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)

				return '<Ignore>'
			end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
		end,
	},
},

-- outdented final curly
}
