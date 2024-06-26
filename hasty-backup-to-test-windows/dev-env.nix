{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# Languages
		zig
		rustup
		go
		nodePackages_latest.nodejs
		deno
		bun
		python3
		ruby_3_3
		# swift
		ghc

		# PNPM
		nodePackages.pnpm

		# LSP
		tree-sitter
		zls
		rust-analyzer
		gopls
		gotools
		sqls
		nodePackages.pyright
		ruff-lsp
		rubyPackages.solargraph
		sourcekit-lsp
		haskell-language-server
		lua-language-server
		nil
		nixpkgs-fmt

		vscode-langservers-extracted
		nodePackages.svelte-language-server
		tailwindcss-language-server
		nodePackages.typescript-language-server
		nodePackages.bash-language-server
		marksman

		taplo
		yaml-language-server
		docker-compose-language-service
		dockerfile-language-server-nodejs

		# Debug
		delve
		vscode-extensions.vadimcn.vscode-lldb
	];
}
