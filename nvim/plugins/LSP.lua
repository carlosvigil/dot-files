local lspconfig = require('lspconfig')

return {
	"neovim/nvim-lspconfig",
	opts = {
		lspconfig.bashls.setup {}
		lspconfig.html.setup {}
		lspconfig.cssls.setup {}
		lspconfig.jsonls.setup {}
		lspconfig.svelte.setup {}
		lspconfig.tailwindcss.setup {}
		lspconfig.tsserver.setup {}
		lspconfig.eslint.setup {}
		lspconfig.gopls.setup {}
		lspconfig.lua_ls.setup {}
		lspconfig.rust_analyzer.setup {}
		lspconfig.taplo.setup {}
		lspconfig.dockerls.setup {}
		lspconfig.docker_compose_language_service.setup {}
	}
}
