#!/usr/bin/bash

lxpolkit &
picom -b & # nice windows
source $HOME/.screenlayout/dual_monitors.sh &
nm-applet & # wifi
blueman-applet & # bluetooth
dunst & # notifications
copyq & # clipboard manager
nitrogen --restore & # wallpaper

