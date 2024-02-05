#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

BATTERY_100=􀛨
BATTERY_75=􀺸
BATTERY_50=􀺶
BATTERY_25=􀛩
BATTERY_0=􀛪
BATTERY_CHARGING=􀢋

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

COLOR=$ICON_COLOR
case ${PERCENTAGE} in
  9[0-9]|100) ICON=$BATTERY_100 
  ;;
  [6-8][0-9]) ICON=$BATTERY_75 
  ;;
  [3-5][0-9]) ICON=$BATTERY_50
  ;;
  [1-2][0-9]) ICON=$BATTERY_25; COLOR=$ORANGE
  ;;
  *) ICON=$BATTERY_0; COLOR=$RED
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
fi

sketchybar --set $NAME label="$PERCENTAGE% |" icon="$ICON" icon.color=$COLOR

