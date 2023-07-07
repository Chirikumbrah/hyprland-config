#!/bin/bash


case $1 in
    powermenu)
        uptime="$(uptime -p | sed -e 's/up //g')"
        host="$(hostname)"

        # Options
        shutdown=' Shutdown'
        reboot=' Reboot'
        lock=' Lock'
        logout=' Logout'
        yes=' Yes'
        no=' No'

        # Rofi CMD
        rofi_cmd() {
        	rofi -dmenu \
        		-p "$host" \
        		-mesg "Uptime: $uptime" \
              -width 10 \
              -lines 6
        }

        # Pass variables to rofi dmenu
        run_rofi() {
        	echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
        }

        # Actions
        chosen="$(run_rofi)"
        case ${chosen} in
            $shutdown)
                dunstify -t 1000 "shutting down..." -u low
                # sudo poweroff
                ;;
            $reboot)
                dunstify -t 1000 "rebooting..." -u low
                # sudo reboot
                ;;
            $lock)
                dunstify -t 1000 "locking..." -u low
                # sh "$HOME/.scripts/system/lock.sh"
                ;;
            $logout)
                dunstify -t 1000 "exiting..." -u low
                # dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )
                ;;
        esac

        # if [ "$SELECTED" = "l" ] || [ "$SELECTED" = "lock" ] || [ "$SELECTED" = "д" ]; then
        # elif [ "$SELECTED" = "e" ] || [ "$SELECTED" = "exit" ] || [ "$SELECTED" = "у" ]; then
        #     [[ -n "$dwm" ]] && kill -s TERM "$dwm"

        # elif [ "$SELECTED" = "r" ] || [ "$SELECTED" = "reboot" ] || [ "$SELECTED" = "к" ]; then
        # elif [ "$SELECTED" = "s" ] || [ "$SELECTED" = "shutdown" ] || [ "$SELECTED" = "ы" ]; then
        #     dunstify -t 1000 "shutting down..." -u low
        #     sudo poweroff
        # fi
    ;;
    apps)
        rofi -show drun -matching fuzzy
    ;;
    clipmenu)
        CM_LAUNCHER=rofi clipmenu -fn "$FONT" -nb "$NORMBGCOLOR" -nf "$NORMFGCOLOR" -sb "$SELBGCOLOR" -sf "$SELFGCOLOR"
    ;;
esac
