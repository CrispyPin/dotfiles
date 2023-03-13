#!/bin/bash
path=$(xdg-user-dir PICTURES)/screenshots/screen-$(date "+%Y-%m-%d_%H:%M:%S").png
mkdir -p $(xdg-user-dir PICTURES)/screenshots
maim -u -o $path
xclip -selection clipboard -target image/png -i $path
