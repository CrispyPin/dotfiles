#!/bin/bash

location=$(cat ~/dotfiles/location.txt)
echo "getting weather for "$location
echo

curl "wttr.in/"$location"?2QFn"