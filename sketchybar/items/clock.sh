#!/bin/bash

source colors.sh

sketchybar --add item clock right                              \
           --set clock   update_freq=5                         \
                         icon.drawing=off                      \
                         script="$PLUGIN_DIR/clock.sh"         \
                 background.color=$ITEM_BG_COLOR \
                 background.height=$ITEM_HEIGHT \
                 background.border_color=$BORDER_COLOR                  \
                 background.border_width=$BORDER_WIDTH                              \
                 background.corner_radius=$CORNER_RADIUS \
                 blur_radius=$BLUR_RADIUS \
                 label.padding_left=$PADDING_LEFT \
                 label.padding_right=$PADDING_RIGHT \

