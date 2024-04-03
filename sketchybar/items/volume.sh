#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                 background.color=$ITEM_BG_COLOR \
                 background.height=$ITEM_HEIGHT \
                 background.corner_radius=$CORNER_RADIUS \
                 blur_radius=$BLUR_RADIUS \
                 icon.padding_left=$PADDING_LEFT \
                 icon.padding_right=$GAP \
                 background.border_color=$BORDER_COLOR                  \
                 background.border_width=$BORDER_WIDTH                              \
                 label.padding_right=$PADDING_RIGHT \
                 update_freq=2 \
            --subscribe volume mouse.entered mouse.exited mouse.clicked volume_change

