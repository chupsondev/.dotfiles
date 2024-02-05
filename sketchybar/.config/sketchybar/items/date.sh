#!/usr/bin/env bash

sketchybar  --add item  date e                          \
            --set date  update_freq=5                   \
                        script="$PLUGIN_DIR/date.sh"    \
                        icon.drawing=off                \
                        icon.width=0                    \
                        padding_left=5
