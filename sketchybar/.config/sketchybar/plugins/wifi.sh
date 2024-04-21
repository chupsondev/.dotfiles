#!/usr/bin/env bash

WIFIACTIVEICON=􀙇
WIFIINACTIVEICON=􀙈

INFO="$(ifconfig en0 | awk '/status:/{print $2}')"

ICON=""
if [[ -n "$INFO" ]]; then
    ICON="$WIFIACTIVEICON"
    LABEL="connected |"
else 
    ICON="$WIFIINACTIVEICON"
    LABEL="|"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
