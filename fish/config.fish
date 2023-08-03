if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
alias l "ls -hAGg"
alias ll "ls -l"
alias wtr "weather.sh"
alias wifi "nmcli device wifi rescan && nmcli device wifi list"
alias ff fastfetch
alias pf pfetch
alias gst "git status"
alias glog "git log --oneline"
alias cac "cargo clippy"
alias car "cargo run"
alias carr "cargo run --release"
alias cacp "cargo clippy -- -W clippy::pedantic"
alias tab "echo \"hard_tabs = true\" > rustfmt.toml"
alias :3 "echo meow :3"
alias py python
fish_add_path /home/crispypin/bin/
fish_add_path /home/crispypin/.cargo/bin
fish_add_path /home/crispypin/bin/scripts
fish_add_path /home/crispypin/bin/snoud
fish_add_path /home/crispypin/bin/sinpin-vr
