function upUp
    echo \n# Updating and cleaning Homebrew;
    brew doctor; brew update; brew update; brew upgrade; brew cleanup;
    echo \n# Updating NodePackageManager;
    npm -g outdated; npm -g update; npm -g upgrade
end

