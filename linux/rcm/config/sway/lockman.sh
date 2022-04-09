#!/bin/sh
# Times the screen off and puts it to background
swayidle \
    timeout 10 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
swaylock \
    --clock \
    --indicator \
    --screenshots \
    --effect-scale 0.2 \
    --effect-vignette 0.2:1 \
    --effect-blur 10x5 \
    --datestr "%a %e.%m.%Y" \
    --timestr "%k:%M" \
    --indicator-radius 0 \
    --indicator-thickness 0 \
    --fade-in 0.2

# Kills last background task so idle timer doesn't keep running
kill %%
