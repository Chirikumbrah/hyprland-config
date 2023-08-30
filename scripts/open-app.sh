#!/bin/bash

APP=$1
CLASS=$2
WORKSPACE=$3

if hyprctl clients | ug "class: $CLASS"; then
	hyprctl dispatch workspace "$WORKSPACE" 
else
	hyprctl dispatch exec "$APP"
fi

