# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

source /opt/homebrew/opt/asdf/libexec/asdf.sh

if type brew &>/dev/null
then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

	autoload -Uz compinit
	compinit
fi

# PNPM
export PNPM_HOME="/Users/c/Library/pnpm"
case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) export PATH="$PNPM_HOME:$PATH" ;;
esac

PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"

# Go
# export GOPATH=$(asdf where golang)/packages
# export GOROOT=$(asdf where golang)/go
export PATH="${PATH}:$(go env GOPATH)/bin"

# rustup shell setup
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
		*:"/Users/c/.asdf/installs/rust/1.74.0/bin":*)
			;;
		*)
			# Prepending path in case a system-installed rustc needs to be overridden
			export PATH="/Users/c/.asdf/installs/rust/1.74.0/bin:$PATH"
			;;
esac

# Python
export PATH="/Users/c/Library/Python/3.9/bin:$PATH"

# crytal bug
export CRYSTAL_OPTS="--link-flags=-Wl,-ld_classic"
