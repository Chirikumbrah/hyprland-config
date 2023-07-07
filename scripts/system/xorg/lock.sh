#!/bin/sh

set -e
xset s off dpms 0 11 0

# DRACULA COLORS
alpha='dd'
background='#282a36'
selection='#44475a'
comment='#6272a4'

yellow='#f1fa8c'
orange='#ffb86c'
red='#ff5555'
magenta='#ff79c6'
blue='#6272a4'
cyan='#8be9fd'
green='50fa7b'
purple="#bd93f9"

i3lock \
  --nofork                         \
  --color=$background              \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$selection$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue$alpha \
  --line-uses-ring \
  --keyhl-color=$magenta$alpha \
  --bshl-color=$orange$alpha \
  --separator-color=$selection$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --time-color=$purple \
  --date-color=$yellow       \
  --layout-color=$cyan       \
  --clock \
  --keylayout 1               \
  --indicator \
  --ignore-empty-password     \
  --time-str="%H:%M:%S" \
  --date-str="%A %e %B %Y" \
  --verif-text="Checking..." \
  --wrong-text="Wrong pswd" \
  --noinput="No Input" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --radius=120 \
  --ring-width=10 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys 

xset s off -dpms
