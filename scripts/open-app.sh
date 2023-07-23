#!/bin/bash

APP=$1
WORKSPACE=$2

if $(hyprctl clients | rg -q "class: $APP"); then
	hyprctl dispatch workspace "$WORKSPACE" 
else
	hyprctl dispatch exec "$APP"
	hyprctl dispatch workspace "$WORKSPACE" 
fi

