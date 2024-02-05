#!/usr/bin/env bash

sketchybar  --add item battery right                            \
            --set battery   script="$PLUGIN_DIR/battery.sh"     \
                            label.drawing=on                    \
            --subscribe battery power_source_change system_woke \
