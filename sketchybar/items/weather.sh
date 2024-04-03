#!/bin/bash

source colors.sh

sketchybar -m --add item weather right \
              --set weather update_freq=3600 \
                        script="$PLUGIN_DIR/weather.sh" \
                        background.color=$ITEM_BG_COLOR \
                        background.height=$ITEM_HEIGHT \
                        background.corner_radius=$CORNER_RADIUS \
                        background.border_color=$BORDER_COLOR                  \
                        background.border_width=$BORDER_WIDTH                              \
                        blur_radius=$BLUR_RADIUS \
                        label.padding_left=$PADDING_LEFT \
                        label.padding_right=$PADDING_RIGHT \
