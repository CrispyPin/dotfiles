#!/bin/bash
path=$(xdg-user-dir PICTURES)/screenshots/window_$(date "+%Y-%m-%d_%H:%M:%S").png
mkdir -p $(xdg-user-dir PICTURES)/screenshots
maim -u -i $(xdotool getactivewindow) -o $path
xclip -selection clipboard -target image/png -i $path
