#!/bin/sh

case $1 in
--flameshot) flameshot gui ;;
--slurp) grim -g "$(slurp)" - | swappy -f - ;;
esac
