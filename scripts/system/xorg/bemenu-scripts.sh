#!/bin/bash

FONT="DejaVuSansMono,10.5" # bemenu
NORMBGCOLOR="#bd93f9"
NORMFGCOLOR="#282a36"
SELBGCOLOR="#50fa7b"
SELFGCOLOR="#282a36"
SHELL="/bin/bash"
CM_LAUNCHER=bemenu
BEMENU_OPTS=" \
                --line-height 19 \
            --fn $FONT \
            --cf $NORMBGCOLOR \
            --tb $SELBGCOLOR \
            --tf $SELFGCOLOR \
            --fb $NORMBGCOLOR \
            --ff $SELFGCOLOR \
            --nb $SELFGCOLOR \
            --nf $NORMBGCOLOR \
            --hb '#44475a'\
            --hf '#50fa7b'\
            --sb '#44475a'\
            --sf '#50fa7b'\
            --scb $SELFGCOLOR \
            --scf '#ff79c6'"

case $1 in
    powermenu)
        SELECTED="$(:| bemenu \
            --line-height 19 \
            --fn $FONT \
            --cf $NORMBGCOLOR \
            --tb $SELBGCOLOR \
            --tf $SELFGCOLOR \
            --fb $NORMBGCOLOR \
            --ff $SELFGCOLOR \
            --nb $SELFGCOLOR \
            --nf $NORMBGCOLOR \
            --hb '#44475a'\
            --hf '#50fa7b'\
            --sb '#44475a'\
            --sf '#50fa7b'\
            --scb $SELFGCOLOR \
            --scf '#ff79c6' \
            -i -p "(l)ock  (e)xit  (r)eboot  (s)hutdown" 
        )"

        if [ "$SELECTED" = "l" ] || [ "$SELECTED" = "lock" ] || [ "$SELECTED" = "д" ]; then
            dunstify -t 1000 "locking..." -u low
            sh "$HOME/.scripts/system/lock.sh"
        elif [ "$SELECTED" = "e" ] || [ "$SELECTED" = "exit" ] || [ "$SELECTED" = "у" ]; then
            dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )
            dunstify -t 1000 "exiting..." -u low
            [[ -n "$dwm" ]] && kill -s TERM "$dwm"

        elif [ "$SELECTED" = "r" ] || [ "$SELECTED" = "reboot" ] || [ "$SELECTED" = "к" ]; then
            dunstify -t 1000 "rebooting..." -u low
            sudo reboot
        elif [ "$SELECTED" = "s" ] || [ "$SELECTED" = "shutdown" ] || [ "$SELECTED" = "ы" ]; then
            dunstify -t 1000 "shutting down..." -u low
            sudo poweroff
        fi
    ;;
    apps)
        # j4-dmenu-desktop --use-xdg-de --dmenu="(cat ; (stest -flx   \
        #     $(echo "$PATH" | tr : ' ') | sort -u))    | dmenu       \
        #     -fn '$FONT' -nb '$NORMBGCOLOR' -nf '$NORMFGCOLOR'       \
        #     -sb '$SELBGCOLOR' -sf '$SELFGCOLOR'"
        # j4-dmenu-desktop --use-xdg-de --dmenu="(cat ; (stest -flx   \
        #     $(echo "$PATH" | tr : ' ') | sort -u))    | bemenu"
        bemenu-run
    ;;
    clipmenu)
        clipmenu -fn "$FONT" -nb "$NORMBGCOLOR" -nf "$NORMFGCOLOR" -sb "$SELBGCOLOR" -sf "$SELFGCOLOR"
    ;;
esac
