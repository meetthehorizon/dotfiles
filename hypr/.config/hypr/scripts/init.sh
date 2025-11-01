#!/bin/bash

hyprctl dispatch exec '[workspace 1 silent] wezterm start nvim'
hyprctl dispatch exec '[workspace 2 silent] firefox'
hyprctl dispatch exec '[workspace 3 silent] wezterm'
hyprctl dispatch exec '[workspace 4 silent] spotify'
hyprctl dispatch exec '[workspace 5 silent] obsidian'
hyprctl dispatch exec '[workspace 9 silent] cryptomator'
hyprctl dispatch exec '[workspace 10 silent] anki'

sleep 2
hyprctl dispatch workspace 3
