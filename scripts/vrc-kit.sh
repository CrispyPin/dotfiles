#!/bin/bash

echo "starting screenshot compressor"
kitty -e "vrc-compressor.py" &

echo "starting video player fix"
kitty -e "vrc-mpv" &

echo "starting ovr utils"
kitty -e "/home/crispypin/proj/godot/ovr-utils/builds/linux/ovr-utils.x86_64" &

echo "setting GPU to vr power profile"
sudo GPU_VR.sh
