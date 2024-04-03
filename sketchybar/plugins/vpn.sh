#!/bin/bash

source colors.sh

VPN=$(scutil --nc list | grep Connected)
VPN_DISPLAY_NAME="WireGuard mac"

function onclick() {
  if [[ $VPN != "" ]]; then
    scutil --nc stop "${VPN_DISPLAY_NAME}"
  else
    scutil --nc start "${VPN_DISPLAY_NAME}"
  fi
}

if [[ $VPN != "" ]]; then
  sketchybar -m --set vpn icon= \
                          label="${VPN_DISPLAY_NAME}" \
                          label.padding_right=$PADDING_RIGHT \
                          icon.padding_left=$PADDING_LEFT \
                          icon.padding_right=$GAP \
                          label.drawing=on
else
  sketchybar -m --set vpn label.drawing=off \
    icon.padding_right=$PADDING_RIGHT
fi

case $SENDER in
  "mouse.entered")
    sketchybar -m --set vpn background.color=$ITEM_HOVER_BG_COLOR
    ;;
  "mouse.exited")
    sketchybar -m --set vpn background.color=$ITEM_BG_COLOR
    ;;
  "mouse.clicked")
    onclick
    ;;
esac
