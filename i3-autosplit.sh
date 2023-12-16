#!/bin/sh
var1=$(xwininfo -id `xdotool getwindowfocus` | grep -E '(Width|Height)' | awk 'NR == 1''{print $2}')
var2=$(xwininfo -id `xdotool getwindowfocus` | grep -E '(Width|Height)' | awk 'NR == 2''{print $2}')
if [ $var1 -gt $var2 ]; then
    i3-msg "split h"
    i3-msg "focus up"
    i3-msg "split h"
    i3-msg "focus down"
else
    i3-msg "split v"
    i3-msg "focus left"
    i3-msg "split v"
    i3-msg "focus right"
fi
