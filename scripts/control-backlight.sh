#!/bin/bash

NOTIFICATION_CMD=dunstify

function backlight_notification {
    ICON_LOW="/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-low-symbolic.svg"
    ICON_MEDIUM="/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-medium-symbolic.svg"
    ICON_HIGH="/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-high-symbolic.svg"
    BACKLIGHT=$(light -G | cut -f1 -d".")
    if [ $BACKLIGHT -lt "34" ]; then
        ICON=$ICON_LOW
    elif [ $BACKLIGHT -lt "66" ]; then
        ICON=$ICON_MEDIUM
    else
        ICON=$ICON_HIGH
    fi
    $NOTIFICATION_CMD -i "$ICON" -r 2594 -h int:value:"$BACKLIGHT" " Backlight: $BACKLIGHT%" -t 1000
}

case $1 in
    up)
        backlight_control +2
        backlight_notification &
        ;;
    down)
        backlight_control -2
        backlight_notification &
        ;;
esac
