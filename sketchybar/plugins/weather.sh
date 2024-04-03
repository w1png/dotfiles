function get_weather() {
  echo $(curl -sS https://api.open-meteo.com/v1/forecast\?latitude\=55.7522\&longitude\=37.6156\&current\=temperature_2m\&forecast_days\=1 | jq ".current.temperature_2m")
}

sketchybar -m --set weather label="$(get_weather)°C"
