#!/bin/sh

case $1 in
--flameshot)
    case $2 in
    --full) XDG_CURRENT_DESKTOP=sway flameshot screen ;;
    --partial) XDG_CURRENT_DESKTOP=sway flameshot gui ;;
    esac
    ;;
--slurp) grim -g "$(slurp)" - | swappy -f - ;;
esac
