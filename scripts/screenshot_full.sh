#!/bin/bash
path=$(xdg-user-dir PICTURES)/screenshots/screen-$(date "+%Y-%m-%d_%H:%M:%S").png
mkdir -p $(xdg-user-dir PICTURES)/screenshots

if [ $XDG_SESSION_TYPE = 'wayland' ]; then
	grim $path
	wl-copy -t image/png < $path
else
	maim -u -o $path
	xclip -selection clipboard -target image/png -i $path
fi

