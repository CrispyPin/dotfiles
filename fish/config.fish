if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
alias l "ls -hAGg"
alias wtr "weather.sh"
alias wifi "nmcli device wifi rescan && nmcli device wifi list"
fish_add_path /home/crispypin/bin/scripts
