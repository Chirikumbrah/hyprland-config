#!/bin/bash

# DRACULA COLORS
ORANGE="^c#ffb86c^"
PURPLE="^c#bd93f9^"
GREEN="^c#50fa7b^"
CYAN="^c#8be9fd^"
PINK="^c#ff92df^"
YELLOW="^c#f1fa8c^"

# INIT
printf "$$" > /tmp/yrbar
sec=0

# MODULES
update_cputemp () { 
	ICON=""
	TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
	cputemp="$CYAN$ICON $((TEMP / 1000))°C"
}

update_used_ram () { 
	ICON=""
	RAM="$(free -h | awk 'FNR==2{ print $3 }' | tr -d "i")"
	memory="$GREEN$ICON $RAM"
}

update_bat () {
	BATTERY_STATE=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "state|to full" | awk '{print $2}')
	BATTERY_POWER=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
	if [[ "${BATTERY_STATE}" = "pending-charge" ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -gt 80 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -gt 60 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -gt 40 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -gt 20 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -gt 10 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	elif [[ "${BATTERY_STATE}" = "discharging" && "${BATTERY_POWER}" -le 10 ]]; then
	    BAT=" ${BATTERY_POWER}%"
	else
	    BAT=" ${BATTERY_POWER}%"
	fi
	bat="$PINK$BAT"
}

update_date () { 
	# FULLDATEFMT=${FULLDATEFMT:-"+%A %d %B %Y"}
	ICON=""
	date_var="$YELLOW$ICON $(date "+%a %d %b" | awk '{ print tolower($0) }')"
}

update_time () { 
	ICON=""
	time="$CYAN$ICON $(date '+%H:%M')"
}

update_kbd () {
	ICON=""
	CAPS=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
	if [ "$CAPS" = "on" ]; then
	    LAYOUT="$(xkblayout-state print %s | awk '{print toupper($0)}')"
	else
	    LAYOUT="$(xkblayout-state print %s | awk '{print $0}')"
	fi
	kbd="$GREEN$ICON $LAYOUT"
}

update_disks () { 
	USER_SIGN="~"
  USER_LABEL="$PURPLE$USER_SIGN"
	USER_DISK_USAGE=$(df -h "/home/yr/yrData" | awk '/\/.*/ { print $4; exit 0 }')
	ROOT_SIGN="/"
  ROOT_LABEL="$ORANGE$ROOT_SIGN"
	ROOT_DISK_USAGE=$(df -h "/" | awk '/\/.*/ { print $4; exit 0 }')
	user_disk="$USER_LABEL $USER_DISK_USAGE"
	root_disk="$ROOT_LABEL $ROOT_DISK_USAGE"
}

update_vol () { 
	VOL=$(pamixer --get-volume-human | tr -d '%')
	[ "${VOL}" = "muted" ] || [ "${VOL}" = "0" ] && AUDIO="" || AUDIO=" ${VOL}%"
	vol="$PURPLE$AUDIO"
}

update_mic () {
	STATUS_LINE=$(amixer get Capture | tail -n 1)
	STATUS=$(echo "${STATUS_LINE}" | grep -wo "off")
	[ "${STATUS}" = "off" ] && ICON="" || ICON=""
	mic=$PINK$ICON
}

update_backlight () { 
	ICON=""
	BRIGHTNESS=$(xbacklight -get | cut -f1 -d'.')
	backlight="$YELLOW$ICON $BRIGHTNESS%"
}

display () { 
	#printf "%s\n" " $event [$weather] [$memory $cpu] [$bat] [$backlight] [$vol] $time "
  SEP="^c#ffffff^|"
	xsetroot -name "$vol $SEP $mic $SEP $backlight $SEP $cputemp $SEP $memory $SEP $root_disk $SEP $user_disk $SEP $bat $SEP $date_var $SEP $time $SEP $kbd" &
}


# modules that don't update on their own need to be run at the start for getting their initial value
update_time 	# update time every 5 seconds
update_bat
update_cputemp
update_used_ram
update_date 	
update_vol
update_mic
update_disks
update_backlight
update_kbd
display

# SIGNALLING
# trap	"<function>;display"		"RTMIN+n"
trap	"update_vol;display"		    "RTMIN+1"
trap	"update_mic;display"		    "RTMIN+2"
trap	"update_backlight;display" 	"RTMIN+3"
trap	"update_kbd;display"    		"RTMIN+4"
# to update it from external commands
##"$(cat ~/.cache/yrbar)"
# where m = 34 + n

while true
do
	sleep 1 & wait && {
		# to update item ever n seconds with a offset of m
		## [ $((sec % n)) -eq m ] && udpate_item
		[ $((sec % 5  )) -eq 0 ] && update_time 	# update time every 5 seconds
		[ $((sec % 5  )) -eq 0 ] && update_bat
		[ $((sec % 5  )) -eq 0 ] && update_cputemp
		[ $((sec % 5  )) -eq 0 ] && update_used_ram
		[ $((sec % 10 )) -eq 0 ] && update_date 	
		[ $((sec % 10 )) -eq 0 ] && update_vol
		[ $((sec % 10 )) -eq 0 ] && update_mic
		[ $((sec % 10 )) -eq 0 ] && update_disks
		#[ $((sec % 300)) -eq 1 ] && update_event

		# how often the display updates ( 5 seconds )
		[ $((sec % 5 )) -eq 0 ] && display
		sec=$((sec + 1))
	}
done 

