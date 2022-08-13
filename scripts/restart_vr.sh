#!/bin/bash
# restarts steamvr
killall vrmonitor
sleep 5
RADV_DEBUG=zerovram steam steam://rungameid/250820
sleep 4
./proj/godot/ovr-utils/builds/linux/ovr-utils.x86_64
