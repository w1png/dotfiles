#!/bin/bash

source colors.sh

sketchybar --add item front_app left \
           --set front_app script="$PLUGIN_DIR/front_app.sh"            \
                  background.height=$ITEM_HEIGHT \
                  background.color=0xff000000 \
                  update_freq=5 \
           --subscribe front_app front_app_switched
