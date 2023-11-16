local vo = vim.opt

vim.g.loaded_perl_provider = 0
vo.termguicolors = true

vo.number = true
vo.relativenumber = true
vo.cursorline = true

-- mouse in all modes
vo.mouse = 'a'
-- hover on bufferline
vo.mousemoveevent = true

vo.hlsearch = false
vo.smartcase = true

vo.expandtab = false
vo.shiftwidth = 0
vo.tabstop = 3
vo.copyindent = true
vo.preserveindent = true
vo.list = true
vo.listchars = { tab = "│ ", multispace = "·", trail = "·"}

vo.bs = 'start'

vo.foldmethod = "expr"
vo.foldexpr = "nvim_treesitter#foldexpr()"
vo.foldenable = false

colors_indent_delimiters = {
	'dragonRed',
	'dragonBlue',
	'dragonYellow',
	'dragonGreen',
	'dragonViolet',
	'dragonOrange',
	'dragonCyan',
}
