function update_display_padding() {
  MAC_DISPLAY_UUID="37D8832A-2D66-02CA-B9F7-8F30A301B230"

  DISPLAYS=$( yabai -m query --displays | jq -c .[])

  if [ $(echo $DISPLAYS | jq -c length) -eq 1 ]
  then
    DISPLAY=$(echo $DISPLAYS | jq -c .[0])
    for SPACE in $(echo $DISPLAY | jq -c .spaces[])
    do
      yabai -m config --space $(echo $SPACE) top_padding 10
    done
    exit
  fi

  for DISPLAY in $DISPLAYS
  do
    if [ "$(echo $DISPLAY | jq -r .uuid)" != "$MAC_DISPLAY_UUID" ]
    then
      echo "Setting top padding to 0 for display $(echo $DISPLAY)"
      for SPACE in $(echo $DISPLAY | jq -c .spaces[])
      do
        yabai -m config --space $(echo $SPACE) top_padding 45
      done
    fi
  done
}

update_display_padding
