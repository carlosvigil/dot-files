#!/bin/bash
# TODO: duplicate and translate for linux containers
# FOR A FRESH MAC INSTALL
T=$(date +"%x %r %Z")
arg=$1

get_brew() {
  echo "Getting BREW and some formulae..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Doctor..."
  brew doctor
  echo "Update 2x..."
  brew update && brew update
  echo "Installing: bat, helix, nvim, git, gh, ag, ranger, curl"
  brew install bat helix neovim git gh ag ranger curl
  echo "Installing casks: soundsource, vlc, vscode, fontbase, and numi..."
  brew install --cask soundsource vlc visual-studio-code fontbase numi
  echo "Installing patched font..."
  brew tap homebrew/cask-fonts
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
  get_vim_plug
  echo "All done."
  echo [$T]
}

# RUN
start
exit $?
