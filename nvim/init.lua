-- TODO: add a config for VSCode
-- TODO: remove or configure TreeSitter/LSP
-- TODO: test, fix, configure Telescope extensions fzf & harpoon

require 'opts'
require 'keys'

if not vim.g.vscode then
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup('plugins')
end
