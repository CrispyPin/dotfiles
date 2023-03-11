if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
alias l "ls -hAGg"
alias ll "ls -l"
alias wtr "weather.sh"
alias wifi "nmcli device wifi rescan && nmcli device wifi list"
alias pass "head -c 42 /dev/urandom | base64"
alias ff fastfetch
alias pf pfetch
alias gst "git status"
alias glog "git log --oneline"
fish_add_path /home/crispypin/bin/scripts
fish_add_path /home/crispypin/bin/snoud
