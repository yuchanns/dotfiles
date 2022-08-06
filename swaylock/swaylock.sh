#!/bin/bash

nwg-wrapper -s swaylock-time.sh -o Unknown-1 -r 20000 -c timezones.css -p right -mr 50 -a start -mt 0 -j right -l 3 -sq 31 &

pic=$(rffd -p /usr/share/backgrounds/sway/)
sleep 0.5 && swaylock --image $pic && pkill -f -31 nwg-wrapper
