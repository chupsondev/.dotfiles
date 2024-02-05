#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

sid=0
for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                \
             --set space.$sid associated_space=$sid                     \
                              ignore_association=on                     \
                              label=${SPACE_ICONS[i]}                   \
                              background.corner_radius=0                \
                              label.padding_right=10                    \
                              label.padding_left=10                     \
                              background.padding_right=2                \
                              background.padding_left=2                 \
                              background.y_offset=0                     \
                              background.height=30                      \
                              background.color=$BACKGROUND_1            \
                              background.drawing=off                    \
                              icon.drawing=off                          \
                              script="$PLUGIN_DIR/space.sh"
done
