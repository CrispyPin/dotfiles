#!/bin/bash

STATUSFILE="/tmp/running_screen_recorder"
# check for running instance, stop it and exit
if [ -f $STATUSFILE ]; then
	FFPID=$(<$STATUSFILE)
	kill $FFPID
	rm $STATUSFILE
	exit 0
fi

# select area of screen
if [ $XDG_SESSION_TYPE = 'wayland' ]; then
	SLURP=$(slurp -b#ff44ff22 -w0) || exit 1
	read -r POS DIMS < <(echo $SLURP)
	W=${DIMS%x*}
	H=${DIMS#*x}
else
	SLOP=$(slop -f "%x,%y %w %h" --color=0.8,0.4,1.0,1.0 -t 16) || exit 1
	read -r POS W H< <(echo $SLOP)
fi

OUTPUT_FILE=$(xdg-user-dir VIDEOS)/sel_$(date "+%Y-%m-%d_%H.%M.%S").mp4
LOGFILE="/tmp/screen_recorder_ffmpeg.log"

# make sure selection width and height is even
# even video size needed for yuv420p format
# which is needed for android playback & thumbnails in discord
H=$(( $H - $H%2 ))
W=$(( $W - $W%2 ))

# empty audio track to prevent videos showing up as "GIF" on certain platforms (mastodon)
dummy_audio="-f lavfi -i anullsrc=cl=mono"

if [ $XDG_SESSION_TYPE = 'wayland' ]; then
	echo "fuck (todo figure out wayland ffmpeg shit)"
	# ffmpeg $video_settings -device /dev/dri/card1-re-fkms-grab -i - $OUTPUT_FILE 2> $LOGFILE &
else
	ffmpeg -y $dummy_audio -video_size "$W"x"$H" -f x11grab -framerate 60 \
	-i $DISPLAY+$POS -pix_fmt yuv420p $OUTPUT_FILE 2> $LOGFILE &
fi
# store pid so that recording can be stopped next time the script is run
echo $! > $STATUSFILE
