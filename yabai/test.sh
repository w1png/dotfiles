MAC_DISPLAY_UUID="37D8832A-2D66-02CA-B9F7-8F30A301B230"

DISPLAYS=$( yabai -m query --displays | jq -c .[])

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
