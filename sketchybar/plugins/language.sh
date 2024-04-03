#!/bin/bash

LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

case "$LAYOUT" in
    "ABC") SHORT_LAYOUT="en";;
    "Russian") SHORT_LAYOUT="ru";;
    *) SHORT_LAYOUT="?";;
esac

sketchybar --set language label="$SHORT_LAYOUT"
