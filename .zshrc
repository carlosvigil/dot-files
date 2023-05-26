export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

PS1='in %/ > '

alias zshrc="emacs ~/.zshrc"
alias sosh="source ~/.zshrc"
alias rc="emacs ~/.config/nvim/init.vim"

alias desk="cd ~/Desktop"
alias cvnet="cd ~/Desktop/carlos.network"
alias fcc="cd ~/Desktop/fcc-projects"

alias updateAll="echo '\nUpdating and cleaning Homebrew\n' && brew update && brew update && brew upgrade && brew cleanup && brew prune && echo '\nUpdating and cleaning RubyGems\n' && gem update --system && gem update && gem cleanup && echo '\nUpdating and cleaning NodePackageManager\n' && npm -g outdated && npm -g update"

alias brosy="./node_modules/.bin/browser-sync start -c 'bs-config.js'"
