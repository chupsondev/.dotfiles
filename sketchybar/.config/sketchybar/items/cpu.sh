#!/usr/bin/env bash

sketchybar  --add item cpu right                    \
            --set cpu   script="$PLUGIN_DIR/cpu.sh" \
                        update_freq=2               \ 

