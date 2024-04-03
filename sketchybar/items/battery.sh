#!/bin/bash

source colors.sh

sketchybar --add item battery right \
           --set battery update_freq=120 \
                 script="$PLUGIN_DIR/battery.sh" \
                 background.color=$ITEM_BG_COLOR \
                 background.height=$ITEM_HEIGHT \
                 background.corner_radius=$CORNER_RADIUS \
                 background.border_color=$BORDER_COLOR                  \
                 background.border_width=$BORDER_WIDTH                              \
                 blur_radius=$BLUR_RADIUS \
                 icon.padding_left=$PADDING_LEFT \
                 icon.padding_right=$GAP \
                 label.padding_right=$PADDING_RIGHT \
           --subscribe battery system_woke power_source_change \
