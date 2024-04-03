#!/bin/bash

source colors.sh

sketchybar -m --add item vpn right \
              --set vpn update_freq=1 \
                        icon= \
                        script="$PLUGIN_DIR/vpn.sh" \
                        background.color=$ITEM_BG_COLOR \
                        background.height=$ITEM_HEIGHT \
                        background.corner_radius=$CORNER_RADIUS \
                        background.border_color=$BORDER_COLOR                  \
                        background.border_width=$BORDER_WIDTH                              \
                        blur_radius=$BLUR_RADIUS \
                        icon.padding_left=$PADDING_LEFT \
                        icon.padding_right=$PADDING_RIGHT \
              --subscribe vpn mouse.entered mouse.exited mouse.clicked
