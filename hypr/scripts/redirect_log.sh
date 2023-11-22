#! /bin/bash

LOG_PATH="/tmp/hypr/$(hyprctl instances -j | jq -r '.[0].instance')/hyprland.log"
# cat $LOG_PATH
rm $LOG_PATH && ln -s /dev/null $LOG_PATH
