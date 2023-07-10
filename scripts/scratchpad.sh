#!/bin/bash

APP=$1
SECONDS=$2

if $(hyprctl clients | rg -q "$APP"); then
	hyprctl dispatch togglespecialworkspace "$APP"
else
	hyprctl dispatch exec [ workspace special:"$APP" ] "$APP" 
	sleep "$SECONDS"
	hyprctl dispatch togglespecialworkspace "$APP"
fi

