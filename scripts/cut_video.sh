#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage:"
	echo "<source> <start_time> <end_time> <name>"
	echo
	echo "Example:"
	echo "cut_video recorded.mp4 1:23 4:31 output"
	echo "which would produce: output.mp4 and output_raw.mp4"
	exit
fi

ffmpeg -i "$1" -ss $2 -to $3 -c copy $4"_raw.mp4"
# ffmpeg -i "$1" -ss $2 -to $3 $4".mp4"
ffmpeg -i $4"_raw.mp4" $4".mp4"
