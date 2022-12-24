#!/bin/bash

location=$(cat ~/dotfiles/location.txt)
echo "getting weather for "$location
echo

curl "v2.wttr.in/"$location"?2F"