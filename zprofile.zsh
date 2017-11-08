export EDITOR='nvim'

NEWLINE=$'\n'
PS1="${NEWLINE}🍣  in %/${NEWLINE} > "

alias zrc="nvim ~/.zshrc"
alias zpro="nvim $ZSH_CUSTOM/zprofile.zsh"
alias sopro="source ~/.zshrc"

alias desk="cd ~/Desktop"
alias cvnet="cd ~/Desktop/carlos.network"
alias fcc="cd ~/Desktop/fcc-projects"

alias updateAll="echo '\nUpdating and cleaning Homebrew\n' && brew update && brew update && brew upgrade && brew cleanup && brew prune && echo '\nUpdating and cleaning RubyGems\n' && gem update --system && gem update && gem cleanup && echo '\nUpdating and cleaning NodePackageManager\n' && npm -g outdated && npm -g update && npm -g upgrade"
