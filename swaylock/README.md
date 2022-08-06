```bash
sudo cp ./rffd /usr/bin/
sudo cp ./swaylock.sh /usr/bin/
chmod +x /usr/bin/rffd
chmod +x /usr/bin/swaylock.sh
cp ./swaylock-time.sh ~/.config/nwg-wrapper/
cp ./timezones.css ~/.config/nwg-wrapper/
chmod +x ~/.config/nwg-wrapper/swaylock-time.sh
```

You may change the display name in `swaylock.sh` which is `Unknown-01` now. Try
to get display name by **wlr-randr** in case of wayland, and **xrandr** for xwayland.

[Source](https://forum.archlabslinux.com/t/script-output-over-a-random-image-in-swaylock/59440)
