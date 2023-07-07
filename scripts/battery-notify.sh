#!/bin/bash

while true; do
    BATTERY_STATE=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "state|to full" | awk '{print $2}')
    BATTERY_POWER=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    if [[ "$BATTERY_STATE" = "pending-charge" ]]; then
        dunstify -i /usr/share/icons/ePapirus/32x32/devices/battery.svg -u low "Normal battery level ($BATTERY_POWER%)" "You can unplug the charger"
        sleep 11m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 45 && "$BATTERY_POWER" -ge 20 ]]; then
        dunstify -i /usr/share/icons/ePapirus/32x32/devices/battery.svg "Medium battery level ($BATTERY_POWER%)" "Time to plug the charger"
        sleep 5m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 20 && "$BATTERY_POWER" -ge 10 ]]; then
        dunstify -i /usr/share/icons/ePapirus/32x32/devices/battery.svg "Low battery level ($BATTERY_POWER%)" "Please plug the charger"
        sleep 2m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -le 10 && "$BATTERY_POWER" -ge 3 ]]; then
        dunstify -i /usr/share/icons/ePapirus/32x32/devices/battery.svg -u critical "Critical battery level ($BATTERY_POWER%)" "Plug the charger immediately!"
        sleep 1m
    elif [[ "$BATTERY_STATE" = "discharging" && "$BATTERY_POWER" -eq 1 ]]; then
        dunstify -i /usr/share/icons/ePapirus/32x32/devices/battery.svg -u critical "Battery almost is empty ($BATTERY_POWER%)!!!" "HEEEEEEEEEEEELP MEEE!!!!" 
        sleep 11
    else
        sleep 5m
    fi
done
