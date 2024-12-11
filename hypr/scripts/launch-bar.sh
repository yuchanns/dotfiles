#!/bin/sh

swww kill
swww-daemon &
# swww img ~/.config/hypr/wallpapers/background_01.jpeg 
# swww img ~/.config/hypr/wallpapers/background_02.jpg 
swww img ~/.config/hypr/wallpapers/asahidake.jpg --outputs eDP-1 
swww img ~/.config/hypr/wallpapers/hakodate.jpg --outputs HDMI-A-1 
~/.config/eww/launch_bar
