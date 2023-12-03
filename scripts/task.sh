sed '/---/q' ~/documents/notes/projects.md \
| sed 's/#.*//;/^$/d' \
| shuf -n1 \
| echo "[$(date +%H:%M)] Work on this for an hour: $(cat -)"
