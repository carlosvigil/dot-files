# CONFIG FOR FISH

if status is-interactive
    ## VARIABLES
    ### CONFIG
    alias v /opt/homebrew/bin/nvim
    alias fishcon '/opt/homebrew/bin/nvim ~/.config/fish/config.fish'
    alias fishfun '/opt/homebrew/bin/nvim ~/.config/fish/functions'
    alias sofish 'source ~/.config/fish/config.fish'

    ### DIRECTORIES
    alias desk 'cd ~/Desktop'
    alias bfb 'cd ~/Documents/Work/Luis/dev'

    ### BREW
    alias bup 'brew update; brew upgrade'
end

