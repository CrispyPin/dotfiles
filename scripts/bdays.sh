#!/bin/bash

date=$(date "+%-d\\/%-m")
echo $(cat ~/documents/notes/bdays.md \
| sed "/ $date/!d" \
| cut -d "|" -f3)
