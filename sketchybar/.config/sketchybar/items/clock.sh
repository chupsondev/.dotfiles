#!/usr/bin/env bash

sketchybar  --add item  clock q             \
            --set clock update_freq=5       \
                        script="$PLUGIN_DIR/clock.sh" \
                        padding_right=5
