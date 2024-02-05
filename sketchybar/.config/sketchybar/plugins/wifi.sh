#!/usr/bin/env bash

WIFIACTIVEICON=􀙇
WIFIINACTIVEICON=􀙈

INFO="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: '  '/ SSID: / {print $2}')"

ICON=""
if [[ -n "$INFO" ]]; then
    ICON="$WIFIACTIVEICON"
    LABEL="$INFO |"
else 
    ICON="$WIFIINACTIVEICON"
    LABEL="|"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
