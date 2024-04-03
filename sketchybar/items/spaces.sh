#!/bin/bash

source colors.sh

SPACE_ICONS=("1 󰍡" "2 󰖟" "3  " "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                 \
             --set space.$sid space=$sid                                 \
                              icon="${SPACE_ICONS[i]}"                     \
                              background.color=$ITEM_BG_COLOR \
                              background.height=$ITEM_HEIGHT \
                              background.corner_radius=$CORNER_RADIUS \
                              blur_radius=$BLUR_RADIUS \
                              icon.padding_left=$PADDING_LEFT \
                              icon.padding_right=$PADDING_RIGHT \
                              label.drawing=off                          \
                              background.border_color=$BORDER_COLOR                  \
                              background.border_width=$BORDER_WIDTH                              \
                              script="$PLUGIN_DIR/space.sh"              \
                              click_script="yabai -m space --focus $sid" \
              --subscribe space.$sid mouse.entered mouse.exited

done

# Separator
# sketchybar --add item space_separator left                         \
#            --set space_separator icon=                            \
#                                  icon.color=$ITEM_BG_COLOR             \
#                                  padding_right=10                  \
#                                  label.drawing=off                 \

