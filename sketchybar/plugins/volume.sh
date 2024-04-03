#!/bin/sh

source colors.sh

function getismuted() {
  echo $(osascript -e "output muted of (get volume settings)")
}

function getvolume() {
  echo $(osascript -e "output volume of (get volume settings)")
}

function onclick() {
  if [[ $(getismuted) == "true" ]]; then
    osascript -e "set volume without output muted"
  else
    osascript -e "set volume with output muted"
  fi
}

function updatevolume() {
  VOLUME=$INFO

  if [[ $(getismuted) == "true" ]]; then
    VOLUME="0"
  else
    if [[ $SENDER = "routine" ]]; then
      VOLUME=$(getvolume)
    fi
  fi

  case $VOLUME in
    [6-9][0-9]|100) ICON="󰕾"
    ;;
    [3-5][0-9]) ICON="󰖀"
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿"
    ;;
    *) ICON="󰖁"
  esac

  sketchybar --set $NAME icon="$ICON" label="$VOLUME%"
}

case $SENDER in
  "volume_change" | "routine")
    updatevolume
    ;;
  "mouse.entered")
    sketchybar -m --set $NAME background.color=$ITEM_HOVER_BG_COLOR
    ;;
  "mouse.exited")
    sketchybar -m --set $NAME background.color=$ITEM_BG_COLOR
    ;;
  "mouse.clicked")
    onclick
    ;;
esac

