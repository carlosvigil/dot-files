# CONFIG FOR FISH

if status is-interactive
	## Aliases
	alias v nvim
	alias h hx
	set -gx FISHCON "$HOME/.config/fish/config.fish"
	alias sofish 'source $HOME/.config/fish/config.fish'

	### DIRECTORIES
	alias desk 'cd $HOME/Desktop'
	alias mellc 'cd $HOME/local/MELLC-metarepo'

	### BREW
	# alias bup 'brew update; brew upgrade'
end

## CONFIG
set -gx ASDF_DIR $HOME/.asdf
source $HOME/.asdf/completions/asdf.fish
set -gx HELIX_RUNTIME $HOME/src/helix/runtime

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
