#!/bin/bash

FONT="DejaVuSansMono:size=10" # dwm
NORMBGCOLOR="#bd93f9"
NORMFGCOLOR="#282a36"
SELBGCOLOR="#50fa7b"
SELFGCOLOR="#282a36"
SHELL="/bin/bash"



case $1 in
    powermenu)
        SELECTED="$(:| dmenu \
            -fn "$FONT" \
            -nb "$NORMBGCOLOR" \
            -nf "$NORMFGCOLOR" \
            -sb "$SELBGCOLOR" \
            -sf "$SELFGCOLOR" \
            -i -p "(l)ock  (e)xit  (r)eboot  (s)hutdown"
        )"

        if [ "$SELECTED" = "l" ] || [ "$SELECTED" = "lock" ] || [ "$SELECTED" = "д" ]; then
            xkblayout-state set 0 # Set en keyboard layout
            dunstify -t 1000 "locking..." -u low
            sh "$HOME/.scripts/system/xorg/lock.sh"
        elif [ "$SELECTED" = "e" ] || [ "$SELECTED" = "exit" ] || [ "$SELECTED" = "у" ]; then
            dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )
            dunstify -t 1000 "exiting..." -u low
            loginctl terminate-user $USER
            # [[ -n "$dwm" ]] && kill -s TERM "$dwm"

        elif [ "$SELECTED" = "r" ] || [ "$SELECTED" = "reboot" ] || [ "$SELECTED" = "к" ]; then
            dunstify -t 1000 "rebooting..." -u low
            sudo systemctl reboot
        elif [ "$SELECTED" = "s" ] || [ "$SELECTED" = "shutdown" ] || [ "$SELECTED" = "ы" ]; then
            dunstify -t 1000 "shutting down..." -u low
            sudo systemctl poweroff
        fi
    ;;
    apps)
        j4-dmenu-desktop --use-xdg-de --dmenu="(cat ; (stest -flx   \
            $(echo "$PATH" | tr : ' ') | sort -u))    | dmenu       \
            -fn '$FONT' -nb '$NORMBGCOLOR' -nf '$NORMFGCOLOR'       \
            -sb '$SELBGCOLOR' -sf '$SELFGCOLOR'"
    ;;
    clipmenu)
        clipmenu -fn "$FONT" -nb "$NORMBGCOLOR" -nf "$NORMFGCOLOR" -sb "$SELBGCOLOR" -sf "$SELFGCOLOR"
    ;;
esac
