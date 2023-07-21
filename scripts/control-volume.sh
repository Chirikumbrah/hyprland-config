#!/bin/bash

NOTIFICATION_CMD=dunstify

function volume_notification {
    volMuted="/usr/share/icons/Papirus-Dark/symbolic/status/audio-volume-muted-symbolic.svg"
    volLow="/usr/share/icons/Papirus-Dark/16x16/panel/volume-level-low.svg"
    volMedium="/usr/share/icons/Papirus-Dark/16x16/panel/volume-level-medium.svg"
    volHigh="/usr/share/icons/Papirus-Dark/16x16/panel/volume-level-high.svg"
    VOL=$(pamixer --get-volume-human)
    VOL_LEVEL=$(pamixer --get-volume)
    if [ "$VOL" = "muted" ]; then
        VOL_ICON=$volMuted
    elif [ "$VOL_LEVEL" -lt "35" ]; then
        VOL_ICON=$volLow
    elif [ "$VOL_LEVEL" -lt "70" ]; then
        VOL_ICON=$volMedium
    elif [ "$VOL_LEVEL" -le "100" ]; then
        VOL_ICON=$volHigh
    fi
    $NOTIFICATION_CMD -i "$VOL_ICON" -r 2593 -h int:value:"$VOL_LEVEL" " Volume: $VOL_LEVEL%" -t 1000
}

function get_mic_volume {
    amixer get Capture | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mic_mute {
    amixer get Capture | grep off >/dev/null
}

function mic_notification {
    MIC_MUTED="/usr/share/icons/Papirus-Dark/symbolic/status/microphone-sensitivity-muted-symbolic.svg"
    MIC_HIGH="/usr/share/icons/Papirus-Dark/symbolic/status/microphone-sensitivity-high-symbolic.svg"
    MIC=$(pamixer --default-source --get-volume-human)
    MIC_LEVEL=$(pamixer --default-source --get-volume)
    [ "$MIC" = "muted" ] || [ "$MIC" = "0%" ] && MIC_ICON=$MIC_MUTED || MIC_ICON=$MIC_HIGH
    $NOTIFICATION_CMD -i "$MIC_ICON" -r 25931 -h int:value:"$MIC_LEVEL" " Microphone: $MIC_LEVEL%" -t 1000
}

case $1 in
up)
    pamixer -i 5
    volume_notification &
    ;;
down)
    pamixer -d 5
    volume_notification &
    ;;
mute)
    pamixer -t
    volume_notification &
    ;;
mic)
    pamixer --default-source -t
    mic_notification &
    ;;
esac
