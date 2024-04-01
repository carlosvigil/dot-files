# CONFIG FOR FISH

if status is-interactive
	function fish_greeting
		echo (date)
	end
	
	# ## ALIASES
	# alias v nvim
	# alias h hx
	# set -gx FISHCON "$HOME/.config/fish/config.fish"
	# alias sofish "source $HOME/.config/fish/config.fish"
	# alias fzpath "echo $PATH | tr ' ' '\n' | fzf"
	
	# ### DIRECTORIES
	# alias desk 'cd $HOME/Desktop'
	# alias mellc 'cd $HOME/local/MELLC-metarepo'
	
	# ### BREW
	# # alias bup 'brew update; brew upgrade'
	
	## COLORS
	fish_config theme choose "Rosé Pine"
	
	## FZF
	set -Ux FZF_DEFAULT_OPTS "
		--color=fg:#908caa,bg:#191724,hl:#ebbcba
		--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
		--color=border:#403d52,header:#31748f,gutter:#191724
		--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
		--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
	
	# Preview file content using bat (https://github.com/sharkdp/bat)
	set -gx FZF_CTRL_T_OPTS "
		--preview 'bat -n --color=always {}'
		--bind 'ctrl-/:change-preview-window(down|hidden|)'"
	
	# CTRL-/ to toggle small preview window to see the full command
	# CTRL-Y to copy the command into clipboard using pbcopy
	set -gx FZF_CTRL_R_OPTS "
		--preview 'echo {}' --preview-window up:3:hidden:wrap
		--bind 'ctrl-/:toggle-preview'
		--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
		--color header:italic
		--header 'Press CTRL-Y to copy command into clipboard'"
	
	# Print tree structure in the preview window
	set -gx FZF_ALT_C_OPTS "--preview 'tree -C {}'"
	
end

## VARS
# set -gx GOPATH "$HOME/go"
# set -gx CARGO_BIN "$HOME/.cargo/bin"
# set -gx PNPM_HOME "$HOME/.local/share/pnpm"

# set -gx EDITOR $(which hx)
# set -gx HELIX_RUNTIME $HOME/.config/helix/runtime

# set -gx GEMINI_API_KEY _REDACTED_

# set -gx ASDF_DIR $HOME/.asdf
# source $HOME/.asdf/asdf.fish
# source $HOME/.asdf/completions/asdf.fish
# source $HOME/.asdf/plugins/golang/set-env.fish

## PATHS
# set -gx PATH "$HOME/.local/bin" $PATH

if not string match -q -- $GOPATH $PATH
	set -gx PATH "$GOPATH" $PATH
	set -gx PATH "$GOPATH/bin" $PATH
end

if not string match -q -- $CARGO_BIN $PATH
	set -gx PATH "$CARGO_BIN" $PATH
end

if not string match -q -- $PNPM_HOME $PATH
	set -gx PATH "$PNPM_HOME" $PATH
end
