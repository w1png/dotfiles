#!/bin/bash

source colors.sh

sketchybar --add item language right \
           --set language script="$PLUGIN_DIR/language.sh" \
                 background.color=$ITEM_BG_COLOR \
                 background.height=$ITEM_HEIGHT \
                 background.corner_radius=$CORNER_RADIUS \
                 background.border_color=$BORDER_COLOR                  \
                 background.border_width=$BORDER_WIDTH                              \
                 blur_radius=$BLUR_RADIUS \
                 label.padding_left=$PADDING_LEFT \
                 label.padding_right=$PADDING_RIGHT \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe language keyboard_change

