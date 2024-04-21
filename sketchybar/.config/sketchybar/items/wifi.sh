#!/usr/bin/env bash

sketchybar  --add item wifi right                       \
            --set wifi  script="$PLUGIN_DIR/wifi.sh"    \
            --set wifi update_freq=100                  \
            --subscribe wifi wifi_change system_woke    \
