#! /bin/bash

LOG_PATH="$XDG_RUNTIME_DIR/hypr/$(hyprctl instances -j | jq -r '.[0].instance')/hyprland.log"
# cat $LOG_PATH
rm $LOG_PATH && ln -s /dev/null $LOG_PATH
