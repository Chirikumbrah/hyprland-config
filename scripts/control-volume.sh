#!/bin/bash

function volume_notification {
    volMuted="/usr/share/icons/Papirus-Dark/16x16/panel/volume-level-muted.svg"
    volSound="/usr/share/icons/Papirus-Dark/16x16/panel/volume-level-high.svg"
    VOL=$(pamixer --get-volume-human)
    VOL_LEVEL=$(pamixer --get-volume)
    [ "$VOL" = "muted" ] || [ "$VOL" = "0%" ]  && VOL_ICON=$volMuted || VOL_ICON=$volSound
    dunstify -i "$VOL_ICON" -r 2593 -h int:value:"$VOL_LEVEL" " Volume: $VOL_LEVEL%" -t 1000
}

function get_mic_volume {
    amixer get Capture | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mic_mute {
    amixer get Capture | grep off > /dev/null
}

function mic_notification {
    micMuted="/usr/share/icons/Papirus-Dark/16x16/panel/mic-off.svg"
    micSound="/usr/share/icons/Papirus-Dark/16x16/panel/mic-on.svg"
    MIC=$(pamixer --default-source --get-volume-human)
    MIC_LEVEL=$(pamixer --default-source --get-volume)
    [ "$MIC" = "muted" ] || [ "$MIC" = "0%" ] && MIC_ICON=$micMuted || MIC_ICON=$micSound
    dunstify -i "$MIC_ICON" -r 25931 -h int:value:"$MIC_LEVEL" " Microphone: $MIC_LEVEL%" -t 1000
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
