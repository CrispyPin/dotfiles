#!/bin/env python3
import time
import os

def notify_fail():
	os.system('notify-send "Restarting SteamVR" "VRChat died again :(" --icon /home/crispypin/pictures/emotes/screech.gif')

def notify_ok():
	os.system('notify-send "Go play VRChat" "It stayed open for 150s" --icon /home/crispypin/pictures/emotes/frogchamp.png')

STATUSFILE = "/tmp/VRC_RUNNING"

is_ok = True
for i in range(150):
	time.sleep(1)
	if not os.path.isfile(STATUSFILE):
		is_ok = False
		break

if is_ok:
	notify_ok()
	exit()
else:
	notify_fail()

## restart steam
os.system("killall vrmonitor")
time.sleep(2)
# start steamvr
os.system("steam steam://rungameid/250820")
# start vrchat
# time.sleep(7)
# os.system("steam steam://rungameid/438100")
