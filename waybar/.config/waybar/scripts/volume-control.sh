#!/usr/bin/env bash

print_error() {
  cat <<"EOF"
Usage: ./volumecontrol.sh -[device] <actions>
...valid devices are...
    i   -- input device
    o   -- output device
    p   -- player application (not handled here)
...valid actions are...
    i   -- increase volume [+2]
    d   -- decrease volume [-2]
    m   -- mute toggle
EOF
  exit 1
}

get_default_sink() {
  wpctl status | awk '/\* \[vol:/{print $2; exit}'
}

get_volume() {
  wpctl get-volume "$(get_default_sink)" | awk '{print int($2 * 100)}'
}

is_muted() {
  wpctl get-volume "$(get_default_sink)" | grep -q MUTED
}

icon() {
  vol=$(get_volume)
  if is_muted || [ "$vol" -eq 0 ]; then
    icon="volume-level-muted"
  elif [ "$vol" -lt 33 ]; then
    icon="volume-level-low"
  elif [ "$vol" -lt 66 ]; then
    icon="volume-level-medium"
  else
    icon="volume-level-high"
  fi
}

send_notification() {
  icon
  notify-send -a "state" -r 91190 -i "$icon" -h int:value:"$vol" "Volume: ${vol}%" -u low
}

notify_mute() {
  if is_muted; then
    notify-send -a "state" -r 91190 -i "volume-level-muted" "Volume: Muted" -u low
  else
    icon
    notify-send -a "state" -r 91190 -i "$icon" "Volume: Unmuted" -u low
  fi
}

action_volume() {
  sink=$(get_default_sink)
  current_vol=$(get_volume)

  case "${1}" in
  i)
    if [ "$current_vol" -lt 100 ]; then
      new_vol=$((current_vol + 2))
      [ "$new_vol" -gt 100 ] && new_vol=100
      wpctl set-volume "$sink" "$((new_vol))%" ;;
    ;;
  d)
    new_vol=$((current_vol - 2))
    [ "$new_vol" -lt 0 ] && new_vol=0
    wpctl set-volume "$sink" "$((new_vol))%" ;;
  esac
}

# Device selection and player control are not directly covered by wpctl.
# This version assumes only default sink manipulation.

# Evaluate device option
while getopts iop DeviceOpt; do
  case "${DeviceOpt}" in
  i|o)
    # PipeWire doesn't differentiate in the same way, so default sink/source assumed
    ;;
  p)
    echo "ERROR: Player control not implemented for PipeWire" && exit 0 ;;
  *) print_error ;;
  esac
done

shift $((OPTIND - 1))

# Execute action
case "${1}" in
i) action_volume i ;;
d) action_volume d ;;
m) wpctl set-mute "$(get_default_sink)" toggle && notify_mute && exit 0 ;;
*) print_error ;;
esac

send_notification
