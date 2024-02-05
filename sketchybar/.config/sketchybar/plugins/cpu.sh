#!/usr/bin/env bash

CPU=$(printf "%.2f\n" $(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5 }'))

ICON=􀫥
sketchybar -m --set $NAME icon=$ICON label="$CPU% |"
