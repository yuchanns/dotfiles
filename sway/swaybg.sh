#!/usr/bin/env sh
while true; do
    PID=`pidof swaybg`
    swaybg -i $(find $HOME/Backgrounds/. -type f | shuf -n1) -m fill &
    sleep 1
    kill $PID
    sleep 599
done
