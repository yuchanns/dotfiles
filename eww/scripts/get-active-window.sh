#!/bin/bash

declare -A dict=(["wezterm"]="wezterm" ["chromium"]="chrome")

hyprctl activewindow -j | jq --raw-output .class
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 grep '^activewindow>>' | stdbuf -o0 awk -F '>>|,' '{ if (index($2, "wezterm") != 0) { print "wezterm" } else { print $2 } }'
