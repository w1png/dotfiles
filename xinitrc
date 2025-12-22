function setup_runlevel() {
  XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
  mkdir -pm 0700 "$XDG_RUNTIME_DIR"
  export XDG_RUNTIME_DIR
  openrc -U default
}

function set_topbar() {
  while true; do
    date=$(date +"%F %R")
    mem=$(free -h | awk '/Mem:/ {print $3"/"$2}')
    docker_containers=$(docker ps -q | wc -l)
    xsetroot -name "  $docker_containers |   $mem |  $date"
    sleep 1m
  done
}

function utils() {
  setxkbmap -layout "us,ru" -option "grp:caps_toggle,grp_led:caps" -option "caps:none"
}

function visuals() {
  # feh --bg-tile /media/storage/wallpapers/bluebonnets_tile.png
  feh --bg-tile /media/storage/wallpapers/black-purple-dot-art.png
}

setup_runlevel
set_topbar &
utils
visuals

exec dbus-run-session dwm
