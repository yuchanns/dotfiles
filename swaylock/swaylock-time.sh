#!/bin/bash

time=$(date +'%a, %d. %b  %H:%M')
echo '<span size="20000" foreground="#c6ad8f" face="monospace">'$time'</span>'
echo; echo '<span size="12000" foreground="#cccccc" face="monospace">'$(echo $USER)'@'$(uname -n) on $(uname -sr)'</span>'
echo '<span size="12000" foreground="#cccccc" face="monospace">'$(uptime -p)'</span>'
