#!/bin/sh

swww kill
swww-daemon &
swww img ~/.config/hypr/assets/wallpapers/asahidake.jpg --outputs eDP-1 
swww img ~/.config/hypr/assets/wallpapers/hakodate.jpg --outputs HDMI-A-1 
swww img ~/.config/hypr/assets/wallpapers/asahidake.jpg --outputs HDMI-A-2
~/.config/eww/launch_bar
