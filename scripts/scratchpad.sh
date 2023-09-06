#!/bin/bash

APP=$1
WORKSPACE_NAME=$2

windows_in() {
    hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$WORKSPACE_NAME\" )"
}

WINDOWS=$(windows_in "$WORKSPACE_NAME")

if [ -z "$WINDOWS" ]; then
    hyprctl dispatch exec [ workspace special:"$WORKSPACE_NAME" ] "$APP"
else
    hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"
fi
