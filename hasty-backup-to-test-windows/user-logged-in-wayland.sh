#!/usr/bin/env dash

udiskie --tray &

# clipboard
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# monitor config
# kanshi --config /home/c/.config/kanshi/config &
# sleep 1; systemctl --user start kanshi.service;

waybar &

# Less blue light
gammastep-indicator -c /home/c/.config/gammastep/gammastep.conf &

# Notifications thing
nm-applet --indicator &

microsoft-edge &
