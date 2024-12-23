#!/bin/bash

if [ $XDG_SESSION_TYPE = 'wayland' ]; then
  grim -g "$(slurp -b#ffff4411 -w0)" - | wl-copy -t image/png
else
  maim -s -u --color=1.0,0.5,0.0,1.0 -t 16 | xclip -selection clipboard -t image/png
fi

