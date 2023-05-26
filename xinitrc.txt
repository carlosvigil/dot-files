#! /usr/local/bin/fish
#xrandr -s 2560x1600;
xrdb -merge -I$HOME ~/.Xresources;
exec xmonad
