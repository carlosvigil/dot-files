# CONFIG FOR FISH

if status is-interactive

	## ALIASES
	alias v nvim
	alias h hx
	set -gx FISHCON "$HOME/.config/fish/config.fish"
	alias sofish 'source $HOME/.config/fish/config.fish'

	### DIRECTORIES
	alias desk 'cd $HOME/Desktop'
	alias mellc 'cd $HOME/local/MELLC-metarepo'

	### BREW
	# alias bup 'brew update; brew upgrade'

	## COLORS
	fish_config theme choose "Rosé Pine"
	
	set -Ux FZF_DEFAULT_OPTS "
		--color=fg:#908caa,bg:#191724,hl:#ebbcba
		--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
		--color=border:#403d52,header:#31748f,gutter:#191724
		--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
		--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

end

## CONFIG
set -gx ASDF_DIR $HOME/.asdf
source $HOME/.asdf/completions/asdf.fish
set -gx HELIX_RUNTIME $HOME/src/helix/runtime
set -gx EDITOR $(which hx)

### PATH
source $HOME/.asdf/asdf.fish
source $HOME/.asdf/plugins/golang/set-env.fish
set -gx PATH "$HOME/.cargo/bin" $PATH

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
	set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
