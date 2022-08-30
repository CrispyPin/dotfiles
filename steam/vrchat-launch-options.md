# vrchat launch options

## using script from this repo:
`$(python3 /home/crispypin/dotfiles/scripts/vrc-monitor.py) & touch /tmp/VRC_RUNNING && %command% --melonloader.hideconsole && rm /tmp/VRC_RUNNING`

## simple standalone:
`$(sleep 150 && notify-send "Gaming time?" "VRChat was launched 150s ago" --icon /home/crispypin/pictures/emotes/screech.gif) & %command% --melonloader.hideconsole`
