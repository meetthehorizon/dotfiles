#!/bin/bash

hyprctl dispatch exec '[workspace 1 silent] code'
hyprctl dispatch exec '[workspace 2 silent] zen-browser'
hyprctl dispatch exec '[workspace 3 silent] wezterm'
hyprctl dispatch exec '[workspace 4 silent] spotify'
hyprctl dispatch exec '[workspace 5 silent] obsidian'

sleep 2
hyprctl dispatch workspace 3
