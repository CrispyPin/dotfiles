`$(python3 /home/crispypin/dotfiles/scripts/vrc-monitor.py) & touch /tmp/VRC_RUNNING && %command% --disable-videoplayers && rm /tmp/VRC_RUNNING`

PROTON_LOG=0 PROTON_LOG_DIR=/tmp %command% -skipsteam --disable-videoplayers --melonloader.hideconsole

--disable-videoplayers --melonloader.hideconsole -skipsteam

--enable-libvlc
