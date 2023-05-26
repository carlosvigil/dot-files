#!/bin/bash
# FOR A FRESH INSTALL
T=$(date +"%x %r %Z")
arg=$1

get_brew() {
  echo "Getting BREW and some formulae..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Doctor..."
  brew doctor
  echo "Update 2x..."
  brew update && brew update
  echo "Installing: fish, nvim, git, gh, ag, ranger, curl, chruby, ruby-install, and deno..."
  brew install fish neovim git gh ag ranger curl chruby ruby-install deno
  echo "Installing casks: kitty, soundsource, vlc, vscodium, fontbase, and numi..."
  brew install --cask kitty soundsource vlc vscodium fontbase numi
  echo "Installing patched font..."
  brew tap homebrew/cask-fonts
  brew install font-victor-mono-nerd-font
  echo "Done brewing."
  return
}

change_def_shell() {
  echo "Changing default shell..."
  echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
  chsh -s /opt/homebrew/bin/fish
  echo "Getting FISHERMAN..."
  curl -Lo $HOME/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  echo "TODO:
  # fish_add_path /opt/homebrew/bin/ /opt/homebrew/sbin/
  # fish_update_completions"
  return
}

get_vim_plug() {
  echo "Getting VIMPLUG..."
  (curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
  return
}

install_yabai() {
  inst="brew install koekeishiya/formulae/yabai"
  serv="brew services start yabai"

  if [ -z $1 ]; then
      local par=$arg
  fi

  case $par in
    y)
      echo "Installing yabai..."
      $inst
      echo "Adding yabai to sudoers..."
      (add_yabai_sudoers)
      echo "Overwriting yabairc with --load-sa..."
      (overwrite_yabairc)
      echo "Starting brew service..."
      $serv
      echo "Yabai!"
      return
      ;;
    "")
      read -p "Did you partially disable SIP? (Y/n) " par
      install_yabai $par
      ;;
    n)
      echo "Skipping sudoers/yabairc creation."
      echo "Installing yabai..."
      $inst
      echo "Starting brew service..."
      $serv
      echo "tsumaranaiyo."
      return
      ;;
    *)
      echo "Invalid entry. Skipping yabai installation."
      return
      ;;
  esac
}

add_yabai_sudoers() {
  local str="$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa"
  echo $str | sudo EDITOR="tee -a" visudo -f /etc/sudoers.d/yabai
}

overwrite_yabairc() {
  #TODO: add yabairc original content back in
  local yrc="$HOME/.yabairc"
  local str='yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"'
  echo $str > $yrc
  echo "sudo yabai --load-sa" >> $yrc
}

start() {
  echo "STARTING [$T]"
  #get_brew
  #change_def_shell
  #get_vim_plug
  install_yabai $1
  echo "All done."
  echo [$T]
}

# RUN
start
exit $?
