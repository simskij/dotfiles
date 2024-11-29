#!/bin/bash

# Author: https://github.com/x0rzavi
# Description: Lock sway with swaylock-effects
# Dependencies: sway
# Theme: Catppuccin

# Variables
transparent=00000000
lavender=C9CBFF
black=161320
peach=F8BD96
yellow=e5c890
green=ABE9B3
red=e78284
wallpapers_path=~/.wallpaper.png

swaylock \
	--ignore-empty-password \
	--daemonize \
	--image $wallpapers_path \
	--scaling fill \
	--indicator-radius 40 \
	--indicator-thickness 2 \
	--bs-hl-color $lavender \
	--key-hl-color $lavender \
	--caps-lock-bs-hl-color $lavender \
	--caps-lock-key-hl-color $lavender \
	--inside-color $transparent \
	--inside-clear-color $transparent \
	--inside-caps-lock-color $transparent \
	--inside-ver-color $transparent \
	--inside-wrong-color $transparent \
	-r \
	--ring-color $lavender \
	--ring-clear-color $black \
	--ring-caps-lock-color $peach \
	--ring-ver-color $yellow \
	--ring-wrong-color $red \
	--separator-color $transparent \
	--text-color $transparent \
	--text-clear-color $transparent \
	--text-ver-color $transparent \
	--text-wrong-color $transparent \
	--text-caps-lock-color $transparent
