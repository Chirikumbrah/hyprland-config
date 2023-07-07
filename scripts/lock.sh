#!/bin/bash

# If idle for 11s, power down the output
swayidle timeout 11 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' &

# Lock screen immediately
swaylock

# Screen unlocked: terminate swayidle and clean up PID
kill -TERM $!
wait