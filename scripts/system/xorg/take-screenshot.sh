#!/bin/sh

case $1 in
    --full)    flameshot screen ;;
    --partial) flameshot gui ;;
esac
