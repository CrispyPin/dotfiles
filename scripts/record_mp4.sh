#!/bin/bash

statusfile="/tmp/running_screen_recorder"
# check for running instance, stop it and exit
if [ -f $statusfile ]; then
	ffpid=$(<$statusfile)
	kill $ffpid
	rm $statusfile
	exit 0
fi

# select area of screen
slop=$(slop -f "%x %y %w %h %g %i" --color=0.8,0.4,1.0,1.0 -t 16) || exit 1
read -r X Y W H G ID < <(echo $slop)

videofile=$(xdg-user-dir VIDEOS)/sel_$(date "+%Y-%m-%d_%H.%M.%S").mp4
logfile="/tmp/screen_recorder_ffmpeg.log"

# make sure selection width and height is even
# even video size needed for yuv420p format
# which is needed for android playback & thumbnails in discord
H=$(( $H - $H%2 ))
W=$(( $W - $W%2 ))

ffmpeg -y -video_size "$W"x"$H" -f x11grab -framerate 60 \
-i $DISPLAY+$X,$Y -pix_fmt yuv420p $videofile 2> $logfile &

# store pid so that recording can be stopped next time the script is run
echo $! > $statusfile
