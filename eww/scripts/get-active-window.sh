#!/bin/bash
hyprctl activewindow -j | jq --raw-output .class
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 grep '^activewindow>>' | stdbuf -o0 awk -F '>>|,' '{print $2}'
