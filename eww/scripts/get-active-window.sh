#!/bin/bash

declare -A dict=(["wezterm"]="Wezterm" ["chromium"]="Chrome" ["dolphin"]="Dolphin" ["firefox"]="Firefox" ["remmina"]="Remmina")

rename_window () {
  local field=$1 # get the field passed as argument
  local regex=$(IFS=\|; echo "${!dict[*]}")
  if [[ $field =~ $regex ]]; then # check if the field matches the regex
    echo ${dict[${BASH_REMATCH[0]}]} # print the value of the matched key
  else
    echo $field # print the field itself
  fi
}

hyprctl activewindow -j | jq --raw-output .class
socat -u UNIX-CONNECT:${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock - | stdbuf -o0 grep '^activewindow>>' | stdbuf -o0 awk -F '>>|,' '{print $2}' | while read field; do rename_window $field; done
