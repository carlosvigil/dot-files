# System-wide programs, i think 
# NOTE: Unsightly configed programs here
# TODO: 'rtfm'

## Tiling Animated Easy
programs.hyprland = {
  enable          = true;
  xwayland.enable = true;
  xwayland.hidpi  = true;
};
programs.waybar.enable = true;

## ZSH
programs.zsh = {
  enable = true;
  ohMyZsh = {
    enable   = true;
    theme    = "frisk";
    custom   = "$HOME/.oh-my-zsh/custom/";
    cacheDir = "$HOME/.cache/oh-my-zsh";
    plugins  = ["git" "gh" "colored-man-pages"];
  };
  syntaxHighlighting = {
    enable       = true;
    highlighters = ["main" "brackets"];
  };
  autosuggestions.enable = true;
};

## GNUPG
programs.gnupg = {
  enable = true;
  agent = {
    enable              = true;
    enableSSHSupport    = true;
    enableBrowserSocket = true;
  };
};

## GIT
## TODO: .config {}
programs.git = {
  enable = true;
};

## NEOVIM
programs.neovim = {
  enable        = true;
  viAlias       = true;
  vimAlias      = true;
  withNodeJs    = true;
  defaultEditor = true;
};

## Firefox
programs.firefox = {
  enable = true;
};

## fzf
programs.fzf.fuzzyCompletion = true;

## htop
programs.htop.enable = true;

## npm
programs.npm.enable = true;

## wshowkeys
programs.wshowkeys.enable = true;