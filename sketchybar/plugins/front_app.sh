#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO"
  echo "$INFO"
fi
