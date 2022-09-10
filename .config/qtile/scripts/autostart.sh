#!/usr/bin/bash

lxpolkit &
picom -b &
nm-applet &
source $HOME/.screenlayout/dual_monitors.sh &
nitrogen --restore &

