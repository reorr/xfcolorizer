#!/bin/bash
echo Applying wallpaper
wallpaper=/home/lemone/Pictures/bg/renders_in_shape/touka3.png&&properties=$(xfconf-query -c xfce4-desktop -p /backdrop -l | grep -e "screen.*/monitor.*image-path$" -e "screen.*/monitor.*/last-image$") && for property in $properties; do xfconf-query -c xfce4-desktop -p $property -s "$wallpaper"; done