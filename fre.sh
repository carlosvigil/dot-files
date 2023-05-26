#!/bin/bash
# FOR A FRESH INSTALL
T=$(date +"%x %r %Z")

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

check_sip() {
    if [ -z $1 ]; then
        local par=$arg
    fi

    case $par in
        y)
            echo "Installing yabai..."
            brew install koekeishiya/formulae/yabai
            return
            ;;
        "")
            read -p "Did you partially disable SIP? (Y/n) " par
            check_sip $par
            ;;
        n)
            echo "Skipping yabai installation."
            return
            ;;
        *)
            echo "Invalid entry. Skipping yabai installation."
            return
            ;;
    esac
}


start() {
    echo "STARTING [$T]"
    sleep 3
    get_brew
    change_def_shell
    get_vim_plug
    check_sip $1
    echo "All done. Closing. [$T]"
    sleep 3
}

# RUN
start
exit $?
