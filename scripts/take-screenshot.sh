#!/bin/sh

export XDG_CURRENT_DESKTOP=sway

case $1 in
    --full)    flameshot screen ;;
    --partial) flameshot gui ;;
esac
