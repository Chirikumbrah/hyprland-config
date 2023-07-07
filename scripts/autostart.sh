#!/bin/bash


# setup dunst daemon
kill $(pgrep -x dunst) &

# set screen timeout
swayidle -w &

# clipboard management
copyq --start-server &

# set proper cursor
hyprctl setcursor Layan-border-cursors 24 &

# battery status notifications
~/.scripts/system/battery-notify.sh &
