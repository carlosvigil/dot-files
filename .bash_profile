# Tidy for Mac OS X by balthisar.com is adding the new path for Tidy.
export PATH=/usr/local/bin:$PATH

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\e[0;35m\]\$(parse_git_branch) \[\033[38;5;220m\]\W\[$(tput sgr0)\] [\D{%T}]\n > "
export EDITOR=vim
alias bashp="vim ~/.bash_profile"
alias sbash="source ~/.bash_profile"
alias vimrc="vim ~/.vimrc"

alias desk="cd ~/desktop"
alias ..="cd .."
alias fcc="cd ~/desktop/fcc-projects/"
alias final="cd D*/C*/'Fall 16'/J*/F*/site"

alias updateAll="brew cleanup && brew prune && brew update && brew update &&
  brew upgrade && brew cleanup && brew prune && gem update && gem cleanup && npm -g outdated && npm -g update"
alias brosy='browser-sync start -s -f "index.html, /css/*.css" -b "google chrome" -b "safari" -b "firefox"'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
