sketchybar --set $NAME background.drawing=$SELECTED

source colors.sh

case $SENDER in
  "mouse.entered")
    sketchybar -m --set $NAME background.color=$ITEM_HOVER_BG_COLOR
    ;;
  "mouse.exited")
    if [[ $SELECTED == "false" ]]; then
      sketchybar -m --set $NAME background.color=0x00000000
    else
      sketchybar -m --set $NAME background.color=$ITEM_BG_COLOR
    fi
    ;;
esac

