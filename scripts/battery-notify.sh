#!/bin/bash

NOTIFICATION_CMD=dunstify

while true; do
    # Icons
    BAT_10="/usr/share/icons/Papirus-Dark/symbolic/status/battery-level-10-symbolic.svg"
    BAT_20="/usr/share/icons/Papirus-Dark/symbolic/status/battery-level-20-symbolic.svg"
    BAT_40="/usr/share/icons/Papirus-Dark/symbolic/status/battery-level-40-symbolic.svg"
    BAT_GOOD="/usr/share/icons/Papirus-Dark/symbolic/status/battery-good-charging-symbolic.svg"
    BAT_CRITICAL="/usr/share/icons/Papirus-Dark/symbolic/status/battery-caution-symbolic.svg"

    # State
    BATTERY_STATE=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "state|to full" | awk '{print $2}')
    BATTERY_POWER=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    if [[ "$BATTERY_STATE" = "pending-charge" ]]; then
        $NOTIFICATION_CMD -i "$BAT_GOOD" -u low "Normal battery level ($BATTERY_POWER%)" "You can unplug the charger"
        sleep 11m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 45 && "$BATTERY_POWER" -ge 20 ]]; then
        $NOTIFICATION_CMD -i "$BAT_40" "Medium battery level ($BATTERY_POWER%)" "Time to plug the charger"
        sleep 5m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 20 && "$BATTERY_POWER" -ge 10 ]]; then
        $NOTIFICATION_CMD -i "$BAT_20" "Low battery level ($BATTERY_POWER%)" "Please plug the charger"
        sleep 2m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 10 && "$BATTERY_POWER" -ge 3 ]]; then
        $NOTIFICATION_CMD -i "$BAT_10" -u critical "Critical battery level ($BATTERY_POWER%)" "Plug the charger immediately!"
        sleep 1m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -eq 1 ]]; then
        $NOTIFICATION_CMD -i "$BAT_CRITICAL" -u critical "Battery is almost empty ($BATTERY_POWER%)!!!" "HEEEEEEEEEEEELP MEEE!!!!" 
        sleep 11
    else
        sleep 5m
    fi
done
