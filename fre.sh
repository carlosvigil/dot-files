#!/usr/bin/env dash
# FOR A FRESH MAC INSTALL
# TODO: check for linux containers, and install into them
# TODO: add dot-files
# TODO: add new vim installation tasks, lazy vim
# TODO: add post-brew-install tasks, i.e. echoes into zshrc

T=$(date +"%x %r %Z")
arg=$1

brews = (asdf
	bat 
	git 
	gh 
	ripgrep 
	lf 
	helix 
	neovim)

casks = (warp 
	visual-studio-code 
	betterdisplay 
	soundsource 
	orbstack 
	utm 
	fontbase 
	numi 
	spotify 
	vlc 
	appcleaner 
	suspicious-package)

install_brew() {
  echo "Getting BREW and some formulae..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Doctor..."
  brew doctor
  echo "Update 2x..."
  brew update && brew update
  echo "Installing brews..."
  brew install $brews
  echo "Installing casks..."
  brew install --cask $casks
  echo "Installing patched font..."
  brew tap homebrew/cask-fonts; \
  brew install font-victor-mono-nerd-font
  echo "Done brewing."
  return
}



get_vim_plug() {
  echo "Getting VIMPLUG..."
  (curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
  return
}

start() {
  echo "STARTING [$T]"
  get_brew
  echo "All done."
  echo [$T]
}

# RUN
start
exit $?
