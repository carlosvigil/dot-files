#!/bin/bash
# FOR A FRESH INSTALL

T=$(date +"%x %r %Z")

get_brew() {
    echo "Getting BREW and some formulae..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew update && brew update
    brew install fish neovim git gh ag ranger curl chruby ruby-install deno
    brew install --cask kitty soundsource vlc vscodium fontbase numi
    return
}

change_def_shell() {
    echo "Changing default shell..."
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/fish
    echo "Getting FISHERMAN..."
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
    echo "TODO:
    # fish_add_path /opt/homebrew/bin/ /opt/homebrew/sbin/
    # fish_update_completions"
    return
}

get_vim_plug() {
    echo "Getting VIMPLUG..."
    (curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
    return
}

start() {
    echo "STARTING [$T]"
    sleep 3
    get_brew
    (change_def_shell)
    (get_vim_plug)
    echo "All done. Closing."
    sleep 3
    exit
}

# RUN
start
exit $?
